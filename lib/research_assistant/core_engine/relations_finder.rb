module ResearchAssistant
  module CoreEngine
    class RelationsFinder

      RELATIONS_SCHEMA = <<~PROMPT
      Please analyze the given text to identify relationships between concepts and provide a structured output in the following JSON format:
        {
          "relationships": [
            {
              "insight": "A concise summary of the identified relationship between concepts in the text.",
              "classification": "The category of the relationship within the analysis. Possible values: causal, comparative, associative, hierarchical.",
              "significance": "A brief explanation of why this relationship is important or how it contributes to understanding the text."
            }
          ]
        }
      PROMPT

      attr_reader :api_client, :json_api_client

      def initialize(api_client, json_api_client)
        @api_client = api_client
        @json_api_client = json_api_client
      end

      def find_relations(topic, text, analysis)
        prompt = "Please analyze the given text to identify relationships between concepts, then think again and generate deeper relationships. The relationships should be of the following types:
                   Topic : #{topic},
                   Text : #{text},
                   Analysis: #{analysis}"
        response = api_client.query(prompt)
        parse_response(response)
      end

      private

      def parse_response(response)
        relationships = json_api_client.query(response, RELATIONS_SCHEMA)
        relationships..is_a?(Hash) ? relationships['relationships'] : relationships
      rescue StandardError => e
        pp " Error in parsing relationships #{e.message}"
        return []
      end
    end
  end
end