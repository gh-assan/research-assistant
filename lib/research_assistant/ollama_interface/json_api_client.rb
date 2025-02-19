require 'json'
require 'faraday'

module ResearchAssistant
  module OllamaInterface
    class JsonApiClient

      attr_reader :model, :conn

      def initialize(model: ResearchAssistant.config.json_model)
        @model = model
        @conn = Faraday.new(url: ResearchAssistant.config.ollama_url) do |f|
          f.request :json
          f.response :json
        end
      end

      def query(prompt, schema)
        response = conn.post('/api/generate') do |req|
          req.body = {
            model: model,
            prompt: "#{prompt} #{schema}",
            stream: false
          }
        end

        raise "API Error: #{response.body['error']}" unless response.success?

        # Parse and return JSON response
        begin
          JSON.parse(response.body['response'])
        rescue JSON::ParserError => e
          raise "JSON Parsing Error: #{e.message}. Response body: #{response.body['response']}"
        end
      rescue Faraday::Error => e
        raise "Connection Error: #{e.message}"
      end
    end
  end
end