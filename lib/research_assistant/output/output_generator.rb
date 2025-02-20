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
          User Intent: #{knowledge.user_intent}
          Topic: #{knowledge.topic}

          Insights:
          #{format_section(knowledge.insights, 'insight', 'classification', 'significance')}

          Concepts:
          #{format_section(knowledge.concepts, 'concept', 'relevance')}

          Knowledge Gaps:
          #{format_section(knowledge.knowledge_gaps, 'insight', 'classification', 'significance')}

          Questions:
          #{format_section(knowledge.questions, 'question', 'type', 'explanation')}

          Relationships:
          #{format_section(knowledge.relations, 'insight', 'classification', 'significance')}

          Last Round Article:
          #{knowledge.last_round_article}
        PROMPT
      end

      def format_section(items, *keys)
        return "None" if items.empty?

        items.map do |item|
          keys.map { |key| "#{key.capitalize}: #{item[key]}" }.join(", ")
        end.join("\n")
      end

      def write_article(prompt)
        write_api_client.write_article(prompt)
      rescue StandardError => e
        raise "Failed to generate article: #{e.message}"
      end
    end
  end
end