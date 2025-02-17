require_relative 'models/response_schema_prompt'

module ResearchAssistant
  module CoreEngine
    class UserIntentExtractor

      attr_reader :json_api_client

      def initialize(json_api_client)
        @json_api_client = json_api_client
      end

      def create_prompt(text)
        response = json_api_client.query(text, Models::USER_INTENT_SCHEMA)
        response['scientific_article_prompt']
      end
    end
  end
end