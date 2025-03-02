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

      EXTRACT_INSIGHTS_PROMPT_TEMPLATE = <<~PROMPT
        Carefully analyze the following text and extract key insights across different dimensions.
        Topic: %<topic>s
        Text: %<text>s
        ----------------------------------------
        First, identify the most critical takeaways, patterns, and underlying themes. Then, take a second pass—go beyond the surface. Generate deeper insights by:
        Identifying hidden connections: What underlying principles, implicit assumptions, or indirect influences are at play?
        Challenging conventional interpretations: How might this text be understood differently through alternative lenses or disciplines?
        Considering future implications: What long-term consequences, speculative ideas, or unanswered questions emerge from this analysis?
        Exploring paradoxes or tensions: Are there contradictions, gaps, or areas where conventional wisdom may be flawed?
        Push the boundaries of interpretation to reveal insights that are not immediately obvious, enriching the depth and originality of the analysis.
      PROMPT

      attr_reader :reasoning_api_client, :json_api_client

      def initialize(api_client, json_api_client)
        @reasoning_api_client = api_client
        @json_api_client = json_api_client
      end

      def analyze(topic, text)
        extract_insights(topic, text)
      end

      private

      def extract_insights(topic, text)
        prompt = format(EXTRACT_INSIGHTS_PROMPT_TEMPLATE, topic: topic, text: text)
        response = reasoning_api_client.query(prompt)
        parse_response(response)
      end

      def parse_response(response)
        insights = json_api_client.query(response, INSIGHTS_SCHEMA)
        insights.is_a?(Hash) ? insights['insights'] : insights
      rescue StandardError => e
        pp " Error in parsing insights #{e.message}"
        return []
      end
    end
  end
end