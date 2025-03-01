module ResearchAssistant
  module CoreEngine
    class InsightsExtractor

      INSIGHTS_SCHEMA = <<~PROMPT
        {
          "insights": [
            {
              "insight": "A concise summary of the extracted concept from the text.",
              "classification": "The category of the concept within the analysis. Possible values: foundational, critical, counterfactual, synthesis.",
              "significance": "A brief explanation of why this insight is important or how it contributes to the overall analysis."
            }
          ]
        }
      PROMPT

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
        prompt = "Analyze the following text and extract key insights then think again and generate deeper insights. The insights should be of the following types:
                  Topic: #{topic}
                  Text: #{text}
                "
        response = api_client.query(prompt)
        parse_response(response)
      end

      private

      def parse_response(response)
        insights = json_api_client.query(response, INSIGHTS_SCHEMA)
        insights..is_a?(Hash) ? insights['insights'] : insights
      rescue StandardError => e
        pp " Error in parsing insights #{e.message}"
        return []
      end
    end
  end
end