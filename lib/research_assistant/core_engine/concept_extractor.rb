require_relative 'models/response_schema_prompt'

module ResearchAssistant
  module CoreEngine
    class ConceptExtractor

      attr_reader :api_client, :json_api_client

      def initialize(api_client, json_api_client)
        @api_client = api_client
        @json_api_client = json_api_client
      end

      def extract(topic, text)
        prompt = "Extract key concepts from the following
                  Topic: #{topic}
                  text: #{text}
                  "
        response = api_client.query(prompt)
        parse_response(response)
      end

      private

      def parse_response(response)
        concepts = json_api_client.query(response, Models::CONCEPTS_SCHEMA)
        concepts..is_a?(Hash) ? concepts['concepts'] : concepts
      rescue StandardError => e
        pp " Error in parsing concepts #{e}"
        return [] 
      end
    end
  end
end