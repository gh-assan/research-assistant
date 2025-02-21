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
          #{format_section(knowledge.insights, 'insight', 'classification', 'significance')}

          Define the following Concepts and their relevance:
          #{format_section(knowledge.concepts, 'concept', 'relevance')}

          Make sure to fill Knowledge Gaps with the following details:
          #{format_section(knowledge.knowledge_gaps, 'insight', 'classification', 'significance')}

          You should answer the Questions with the following details:
          #{format_section(knowledge.questions, 'question', 'type', 'explanation')}

          Use the discovered Relationships to direct your analysis:
          #{format_section(knowledge.relations, 'insight', 'classification', 'significance')}

          Check your last round Responses and build on top of it:
          #{knowledge.last_round_article}
        PROMPT
      end

      def format_section(items, *keys)
        return "None" if items.nil? || items.empty?

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