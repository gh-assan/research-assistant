module ResearchAssistant
  module BrainstormingEngine
    class BaseBrainstorming
      attr_reader :brainstorming_client

      def initialize(brainstorming_client)
        @brainstorming_client = brainstorming_client
      end

      def run(topic, last_round_summary = '')
        prompt = format(self.class::PROMPT, topic: topic, last_round_summary: last_round_summary)
        brainstorming_client.brainstorm(prompt)
      end
    end
  end
end