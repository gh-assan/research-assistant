module ResearchAssistant
  module Output
    class OutputGenerator
      attr_reader :write_api_client

      def initialize(write_api_client)
        @write_api_client = write_api_client
      end

      def generate_article(topic, responses, user_intent, insights, knowledge_gaps, concepts, relations, questions)
        prompt = "#{user_intent}
                  On topic: #{topic}
                  and last round Responses: #{responses}
                  check the extracted Insights: #{insights}
                  and make sure to fill Knowledge Gaps: #{knowledge_gaps}
                  with focus on Concepts: #{concepts}
                  and relations : #{relations}
                  and you should answer the Questions: #{questions}"
        write_api_client.write_article(prompt)
      end
    end
  end
end