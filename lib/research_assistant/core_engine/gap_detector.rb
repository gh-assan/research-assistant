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

      DETECT_PROMPT_TEMPLATE = <<~PROMPT
        Analyze the following response and identify gaps in knowledge, overlooked perspectives, and areas needing further exploration.
        Response: %<response>s
        Analysis: %<analysis>s
        ----------------------------------------
        First, pinpoint missing data, weak arguments, or assumptions that need more evidence. Then, take a second pass—go beyond the surface. Think critically and creatively:
        What unconventional angles or interdisciplinary insights might reveal deeper gaps?
        Are there emerging trends, alternative theories, or speculative ideas that challenge the current understanding?
        What questions remain unanswered, and how could they inspire new research directions?
        Push the boundaries of conventional analysis to uncover gaps that others might miss.
      PROMPT

      attr_reader :reasoning_api_client, :json_api_client

      def initialize(reasoning_api_client, json_api_client)
        @reasoning_api_client = reasoning_api_client
        @json_api_client = json_api_client
      end

      def detect(analysis, response)
        prompt = format(DETECT_PROMPT_TEMPLATE, analysis: analysis, response: response)
        api_response = @reasoning_api_client.query(prompt)
        parse_response(api_response)
      end

      private

      def parse_response(response)
        gabs = json_api_client.query(response, GAPS_SCHEMA)
        gabs.is_a?(Hash) ? gabs['knowledge_gaps'] : gabs
      rescue StandardError => e
        pp " Error in parsing knowledge gaps #{e.message}"
        return []
      end
    end
  end
end