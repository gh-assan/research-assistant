module ResearchAssistant
  module Output
    class OutputGenerator
      attr_reader :write_api_client

      def initialize(write_api_client)
        @write_api_client = write_api_client
      end

      def generate_article(knowledge)
        prompt = "#{knowledge.user_intent}
                  On topic: #{knowledge.topic}
                  check the extracted Insights: #{knowledge.insights}
                  and make sure to fill Knowledge Gaps: #{knowledge.knowledge_gaps}
                  with focus on Concepts: #{knowledge.concepts}
                  and relations : #{knowledge.relations}
                  and you should answer the Questions: #{knowledge.questions}
                  where the last round Responses was: #{knowledge.last_round_article}
                  "
        write_api_client.write_article(prompt)
      end
    end
  end
end