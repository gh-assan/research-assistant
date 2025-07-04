require 'json'
require 'faraday'
require_relative '../concerns/with_retry'

module ResearchAssistant
  module OllamaInterface
    class JsonApiClient
      include WithRetry

      attr_reader :model, :conn

      def initialize(model: ResearchAssistant.config.json_model)
        @model = model
        @conn = Faraday.new(url: ResearchAssistant.config.ollama_url) do |f|
          f.request :json
          f.response :json
          f.options.timeout = 600
          f.options.open_timeout = 600
        end
      end

      # Custom error classes for better error handling
      class JsonApiClientError < StandardError; end
      class JsonApiConnectionError < JsonApiClientError; end
      class JsonApiResponseError < JsonApiClientError; end
      class JsonApiParseError < JsonApiClientError; end

      def log_error(message, exception)
        log_msg = "[JsonApiClient][#{Time.now}] #{message}: #{exception.class} - #{exception.message}\n"
        log_msg += exception.backtrace.first(10).join("\n") if exception.backtrace
        # Ensure log directory exists before writing
        log_dir = File.dirname("log/json_api_client.log")
        Dir.mkdir(log_dir) unless Dir.exist?(log_dir)
        File.open("log/json_api_client.log", "a") { |f| f.puts(log_msg) }
        pp log_msg
      end

      def query(prompt, schema)
        itr = 0
        with_retry do
          itr += 1
          response = conn.post('/api/generate') do |req|
            req.body = {
              model: model,
              prompt: "#{itr} #{prompt} #{schema}",
              stream: false
            }
          end
          pp "JsonApiClient: Raw response body: #{response.body}"
          begin
            handle_response(response)
          rescue JsonApiClientError => e
            log_error("Custom error in handle_response", e)
            raise
          rescue => e
            log_error("Unknown error in handle_response", e)
            raise JsonApiClientError, e.message
          end
        end
      rescue Faraday::Error => e
        log_error("Connection error", e)
        raise JsonApiConnectionError, e.message
      end

      private

      def handle_response(response)
        unless response.success?
          error = JsonApiResponseError.new(response.body['error'] || "Unknown API error")
          log_error("API Error", error)
          raise error
        end
        pp "JsonApiClient: Response body['response']: #{response.body['response']}"
        parsed_json = parse_json(response.body['response'])
        pp "JsonApiClient: Parsed JSON: #{parsed_json}"
        parsed_json
      end

      def parse_json(response_body)
        JSON.parse(response_body)
      rescue JSON::ParserError => e
        error = JsonApiParseError.new("JSON Parsing Error: #{e.message}. Response body: #{response_body}")
        log_error("JSON Parsing Error", error)
        raise error
      end
    end
  end
end