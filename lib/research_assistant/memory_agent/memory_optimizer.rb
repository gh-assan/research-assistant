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
    end
  end
end
