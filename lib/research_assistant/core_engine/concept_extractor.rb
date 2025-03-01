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

      attr_reader :api_client, :json_api_client

      def initialize(api_client, json_api_client)
        @api_client = api_client
        @json_api_client = json_api_client
      end

      def extract(topic, text)
        prompt = "Extract key concepts from the following
                  Topic: #{topic}
                  text: #{text}
                  then think again and generate deeper concepts."
        response = api_client.query(prompt)
        parse_response(response)
      end

      private

      def parse_response(response)
        concepts = json_api_client.query(response, CONCEPTS_SCHEMA)
        concepts..is_a?(Hash) ? concepts['concepts'] : concepts
      rescue StandardError => e
        pp " Error in parsing concepts #{e.message}"
        return [] 
      end
    end
  end
end