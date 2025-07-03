module ResearchAssistant
  module MemoryAgent
    class MemoryOptimizer
      def consolidate_and_forget_memories(all_memories, forgetting_threshold_days = 30)
        updated_memories = {}
        current_time = Time.now.to_i
        forgetting_threshold_seconds = forgetting_threshold_days * 24 * 60 * 60

        all_memories.each do |key, memory_data|
          if memory_data.is_a?(Hash) && memory_data['last_accessed']
            last_accessed = memory_data['last_accessed'].to_i
            age_seconds = current_time - last_accessed

            if age_seconds < forgetting_threshold_seconds
              updated_memories[key] = memory_data
            end
          else
            # If memory_data is not a hash or lacks 'last_accessed', convert it
            updated_memories[key] = { 'value' => memory_data, 'last_accessed' => current_time }
          end
        end
        updated_memories
      end

      def learn_from_memories(all_memories)
        # Placeholder for memory-based learning logic.
        # This could involve:
        # - Identifying frequently occurring patterns or concepts.
        # - Inferring new relationships between memories.
        # - Refining existing knowledge based on new information.
        # For now, let's just return a simple analysis of common keywords.
        keyword_counts = Hash.new(0)
        all_memories.each do |key, memory_data|
          content = memory_data.is_a?(Hash) && memory_data['value'] ? memory_data['value'] : memory_data
          if content.is_a?(String)
            content.downcase.scan(/\b[a-z0-9]+\b/).each do |word|
              keyword_counts[word] += 1
            end
          end
        end
        # Filter out common stop words and single-character words
        filtered_keywords = keyword_counts.reject { |word, count| word.length <= 2 || %w(the a an and or but for nor on in at by with from to of).include?(word) }
        # Sort by count and return top 5
        filtered_keywords.sort_by { |word, count| -count }.to_h
      end
    end
  end
end
