require_relative 'models/response_schema_prompt'

module ResearchAssistant
  module CoreEngine
    class InsightsExtractor
      
      attr_reader :api_client, :json_api_client

      def initialize(api_client, json_api_client)
        @api_client = api_client
        @json_api_client = json_api_client
      end

      def analyze(topic, text)
        extract_insights(topic, text)
      end

      private

      def extract_insights(topic, text)
        prompt = "Analyze the following text and extract key insights
                  Topic: #{topic}
                  Text: #{text}
                "
        response = api_client.query(prompt)
        parse_response(response)
      end

      private

      def parse_response(response)
        insights = json_api_client.query(response, Models::INSIGHTS_SCHEMA)
        insights..is_a?(Hash) ? insights['insights'] : insights
      rescue StandardError => e
        pp " Error in parsing insights #{e}"
        return []
      end
    end
  end
end