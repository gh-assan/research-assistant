module ResearchAssistant
  module CoreEngine
    class BaseExtractor

      PROMPT = <<~PROMPT
        Topic: %<topic>s
        Article: %<article>s
      PROMPT

      attr_reader :api_client

      def initialize
        @api_client = ResearchAssistant::OllamaInterface::ApiClient.new(self.class::MODEL)
      end

      def extract(topic, article = '')
        prompt = format(self.class::PROMPT, topic: topic, article: article)
        api_client.query(prompt)
      end
    end
  end
end