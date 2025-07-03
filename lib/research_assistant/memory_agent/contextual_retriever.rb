module ResearchAssistant
  module MemoryAgent
    class ContextualRetriever
      def retrieve_contextual_memories(all_memories, context, limit = 5)
        relevant_memories = []
        context_keywords = extract_keywords_from_context(context)
        significant_context_keywords = context_keywords.select { |k| k.length > 3 }

        all_memories.each do |key, value|
          # Ensure value is a hash and extract the actual content for searching
          memory_content = value.is_a?(Hash) && value['value'] ? value['value'] : value

          if significant_context_keywords.any? { |keyword| memory_content.to_s.downcase.include?(keyword.downcase) }
            relevant_memories << { key: key, value: value }
          end
        end

        relevant_memories.sort_by! do |memory|
          score = 0
          # Ensure memory[:value] is a hash and extract the actual content for scoring
          memory_content = memory[:value].is_a?(Hash) && memory[:value]['value'] ? memory[:value]['value'] : memory[:value]

          context_keywords.each do |keyword|
            score += 1 if memory_content.to_s.downcase.include?(keyword.downcase)
          end
          -score
        end

        relevant_memories.take(limit)
      end

      private

      def extract_keywords_from_context(context)
        context.to_s.downcase.scan(/\b[a-z0-9]+\b/).uniq
      end
    end
  end
end
