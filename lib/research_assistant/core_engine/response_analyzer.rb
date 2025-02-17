require_relative 'models/response_schema_prompt'

module ResearchAssistant
  module CoreEngine
    class ResponseAnalyzer
      
      attr_reader :api_client, :json_api_client

      def initialize(api_client, json_api_client)
        @api_client = api_client
        @json_api_client = json_api_client
      end

      def analyze(text, analysis)
        insights = extract_insights(text)
        analysis[:insights] = insights
        analysis
      end

      private

      def extract_insights(text)
        prompt = "Analyze the following text and extract key insights : #{text}"
        response = api_client.query(prompt)
        parse_response(response)
      end

      private

      def parse_response(response)
        json_api_client.query(response, Models::INSIGHTS_SCHEMA)
      end
    end
  end
end