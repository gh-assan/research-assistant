module ResearchAssistant
  module CoreEngine
    class ConceptExtractor

      CONCEPTS_SCHEMA = <<~PROMPT
        Please analyze the text and respond with the Format below:
        {
          "concepts": [
            {
              "concept": "The text of the concept extracted from the response.",
              "relevance": "The relevance of the concept to the analysis. Possible values: foundational, critical, counterfactual, synthesis."
            }
          ]
        }
      PROMPT

      EXTRACT_PROMPT_TEMPLATE = <<~PROMPT
        Extract key concepts from the following
        Topic: %<topic>s
        text: %<text>s
        -----------------------------------------
        Then, take a second pass—go beyond the obvious. Identify deeper, underlying themes,
        hidden connections, and abstract principles that might not be immediately apparent.
        Consider alternative perspectives, interdisciplinary insights, and conceptual frameworks that could enrich the
        understanding of this topic. Push the boundaries of interpretation and generate novel or speculative ideas that
        could lead to new research directions.
      PROMPT

      attr_reader :api_client, :json_api_client

      def initialize(api_client, json_api_client)
        @api_client = api_client
        @json_api_client = json_api_client
      end

      def extract(topic, text)
        prompt = format(EXTRACT_PROMPT_TEMPLATE, topic: topic, text: text)
        response = api_client.query(prompt)
        parse_response(response)
      end

      private

      def parse_response(response)
        concepts = json_api_client.query(response, CONCEPTS_SCHEMA)
        concepts.is_a?(Hash) ? concepts['concepts'] : concepts
      rescue StandardError => e
        pp " Error in parsing concepts #{e.message}"
        return [] 
      end
    end
  end
end