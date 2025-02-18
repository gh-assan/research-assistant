require_relative 'models/response_schema_prompt'

module ResearchAssistant
  module CoreEngine
    class GapDetector
      attr_reader :api_client, :json_api_client
      def initialize(api_client, json_api_client)
        @api_client = api_client
        @json_api_client = json_api_client
      end

      def detect(analysis, response)
        prompt = "Identify knowledge gaps in the following analysis based on the response: #{response}\n\nAnalysis: #{analysis}"
        api_response = @api_client.query(prompt)
        parse_response(api_response)
      end

      private

      def parse_response(response)
        json_api_client.query(response, Models::GAPS_SCHEMA)
      end
    end
  end
end