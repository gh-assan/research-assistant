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
        prompt = "Identify knowledge gaps in the following analysis based on the response: #{response}\n\nAnalysis: #{analysis} then think again and generate deeper gaps."
        api_response = @api_client.query(prompt)
        parse_response(api_response)
      end

      private

      def parse_response(response)
        gabs = json_api_client.query(response, Models::GAPS_SCHEMA)
        gabs..is_a?(Hash) ? gabs['knowledge_gaps'] : gabs
      rescue StandardError => e
        pp " Error in parsing knowledge gaps #{e.message}"
        return []
      end
    end
  end
end