module ResearchAssistant
  module CoreEngine
    class ConceptExtractor
      def initialize(api_client: ResearchAssistant::OllamaInterface::ApiClient.new)
        @api_client = api_client
      end

      def extract(text)
        prompt = "Extract key concepts return json with the following format [array of concepts contains text and relevance] from the following text: #{text}"
        response = @api_client.query(prompt)
        parse_response(response)
      end

      private

      def parse_response(response)
        # Assuming the response contains a list of concepts
        concepts = JSON.parse(response)
        concepts.map { |concept| { concept: concept['text'], relevance: concept['relevance'] } }
      end
    end
  end
end