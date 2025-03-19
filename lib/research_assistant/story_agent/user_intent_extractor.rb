module ResearchAssistant
  module StoryAgent
    class UserIntentExtractor

      USER_INTENT_SCHEMA = <<~PROMPT
        As a storytelling assistant, analyze the given prompt to understand the user's intent and convert it into a compelling story prompt. Ensure the prompt is concise, engaging, and open-ended to inspire creativity.
        {
           "story_prompt": "A short and engaging prompt for creating a story based on the user's intent."
        }
      PROMPT


      attr_reader :json_api_client

      def initialize(json_api_client)
        @json_api_client = json_api_client
      end

      def create_prompt(text)
        response = json_api_client.query(text, USER_INTENT_SCHEMA)
        response['story_prompt']
      end
    end
  end
end