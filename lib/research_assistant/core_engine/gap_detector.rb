module ResearchAssistant
  module CoreEngine
    class GapDetector

      GAPS_SCHEMA = <<~PROMPT
      Please analyze the given text to identify knowledge gaps in the analysis and provide a structured output in the following JSON format:
        {
            "knowledge_gaps": [
              {
                "insight": "A concise summary of the missing or incomplete concept in the analysis.",
                "classification": "The category of the gap within the analysis. Possible values: foundational, critical, counterfactual, synthesis.",
                "significance": "A brief explanation of why addressing this gap is important for improving the analysis."
              }
            ]
        }
      PROMPT

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
        gabs = json_api_client.query(response, GAPS_SCHEMA)
        gabs..is_a?(Hash) ? gabs['knowledge_gaps'] : gabs
      rescue StandardError => e
        pp " Error in parsing knowledge gaps #{e.message}"
        return []
      end
    end
  end
end