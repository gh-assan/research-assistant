module ResearchAssistant
  module ReviewAgent
    class BaseCommand

      PROMPT = <<~PROMPT
        Perform the following action: %<action>s
        For the following reasons: %<reasons>s
        On
        Topic: %<topic>s
        Text: %<text>s
      PROMPT

      attr_reader :api_client

      def initialize
        @api_client = ResearchAssistant::OllamaInterface::ApiClient.new(self.class::MODEL)
      end

      def execute(topic, text, action)
        prompt = format(self.class::PROMPT, topic: topic, text: text, action: action.name, reasons: action.reasons)
        api_client.query(prompt)
      end
    end
  end
end