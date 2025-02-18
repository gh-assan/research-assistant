require_relative 'models/response_schema_prompt'

module ResearchAssistant
  module CoreEngine
    class RelationsFinder

      attr_reader :api_client, :json_api_client

      def initialize(api_client, json_api_client)
        @api_client = api_client
        @json_api_client = json_api_client
      end

      def find_relations(topic, text, analysis)
        prompt = "Please analyze the given text to identify relationships between concepts:
                   Topic : #{topic},
                   Text : #{text},
                   Analysis: #{analysis}"
        response = api_client.query(prompt)
        parse_response(response)
      end

      private

      def parse_response(response)
        json_api_client.query(response, Models::RELATIONS_SCHEMA)
      end
    end
  end
end