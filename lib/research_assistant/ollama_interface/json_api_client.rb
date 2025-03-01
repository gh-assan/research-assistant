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

      def query(prompt, schema)
        with_retry do
          response = conn.post('/api/generate') do |req|
            req.body = {
              model: model,
              prompt: "#{prompt} #{schema}",
              stream: false
            }
          end

          handle_response(response)
        end
      rescue Faraday::Error => e
        raise "Connection Error: #{e.message}"
      end

      private

      def handle_response(response)
        raise "API Error: #{response.body['error']}" unless response.success?

        parse_json(response.body['response'])
      end

      def parse_json(response_body)
        JSON.parse(response_body)
      rescue JSON::ParserError => e
        raise "JSON Parsing Error: #{e.message}. Response body: #{response_body}"
      end
    end
  end
end