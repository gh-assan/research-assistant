module ResearchAssistant
  module ReviewAgent
    class UserIntentExtractor

      USER_INTENT_SCHEMA = <<~PROMPT
        As a storytelling assistant, analyze the given prompt to understand the user's intent and convert it into a compelling text review prompt. Ensure the prompt is concise, descriptive, and to enhance the overall quality of the text .
        {
           "review_prompt": "A short and clear prompt for reviewing and enhancing a text based on the user's intent."
        }
      PROMPT


      attr_reader :json_api_client

      def initialize(json_api_client)
        @json_api_client = json_api_client
      end

      def create_prompt(text)
        response = json_api_client.query(text, USER_INTENT_SCHEMA)
        response['review_prompt']
      end
    end
  end
end