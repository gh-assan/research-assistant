module ResearchAssistant
  module StoryAgent
    class BaseCommand

      PROMPT = <<~PROMPT
        Perform the following action: %<action>s
        For the following reasons: %<reasons>s
        On
        Topic: %<topic>s
        Story: %<story>s
      PROMPT

      attr_reader :api_client

      def initialize
        @api_client = ResearchAssistant::OllamaInterface::ApiClient.new(self.class::MODEL)
      end

      def execute(topic, story, action)
        prompt = format(self.class::PROMPT, topic: topic, story: story, action: action.name, reasons: action.reasons)
        api_client.query(prompt)
      end
    end
  end
end