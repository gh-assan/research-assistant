module ResearchAssistant
  module CoreEngine
    class UserIntentExtractor

      USER_INTENT_SCHEMA = <<~PROMPT
        As a scientific assistant, analyze the given prompt to understand the user's intent and convert it into a prompt to create a scientific article, make sure the prompt is short and clear.
        {
           "scientific_article_prompt": "A concise and precise prompt for creating a scientific article based on the user's intent."
        }
      PROMPT

      attr_reader :json_api_client

      def initialize(json_api_client)
        @json_api_client = json_api_client
      end

      def create_prompt(text)
        response = json_api_client.query(text, USER_INTENT_SCHEMA)
        response['scientific_article_prompt']
      end
    end
  end
end