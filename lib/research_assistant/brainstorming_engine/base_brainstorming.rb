module ResearchAssistant
  module BrainstormingEngine
    class BaseBrainstorming
      attr_reader :reasoning_api_client

      def initialize(reasoning_api_client)
        @reasoning_api_client = reasoning_api_client
      end

      def run(topic)
        prompt = format(self.class::PROMPT, topic: topic)
        reasoning_api_client.query(prompt)
      end
    end
  end
end