module ResearchAssistant
  module Output
    class OutputGenerator
      attr_reader :write_api_client

      def initialize(write_api_client)
        @write_api_client = write_api_client
      end

      def generate_article(knowledge)
        prompt = build_prompt(knowledge)
        write_article(prompt)
      end

      private

      def build_prompt(knowledge)
        <<~PROMPT
          #{knowledge.user_intent}
          On the Topic: #{knowledge.topic}

          Check the extracted Insights:
          #{knowledge.insights}

          Define the following Concepts and their relevance:
          #{knowledge.concepts}

          Make sure to fill Knowledge Gaps with the following details:
          #{knowledge.knowledge_gaps}

          You should answer the Questions with the following details:
          #{knowledge.questions}

          Use the discovered Relationships to direct your analysis:
          #{knowledge.relations}

          Check your last round Responses and build on top of it:
          #{knowledge.last_round_article}
        PROMPT
      end

      def write_article(prompt)
        write_api_client.write_article(prompt)
      rescue StandardError => e
        raise "Failed to generate article: #{e.message}"
      end
    end
  end
end