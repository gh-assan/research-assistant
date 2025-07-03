require 'json'
require_relative 'memory_store'
require_relative 'contextual_retriever'
require_relative 'memory_optimizer'

module ResearchAssistant
  module MemoryAgent
    class MemoryManager
      def initialize(research_id)
        @base_path = File.join(ResearchAssistant.config.research_dir, research_id)
        @memory_file = File.join(@base_path, 'memory.json')
        pp "MemoryManager: Initializing memory file: #{@memory_file}"

        @memory_store = MemoryStore.new(@memory_file)
        @contextual_retriever = ContextualRetriever.new
        @memory_optimizer = MemoryOptimizer.new
      end

      def read
        @memory_store.read
      end

      def write(data)
        # Update last_accessed timestamp for all memories being written
        data.each do |key, value|
          if value.is_a?(Hash)
            value['last_accessed'] = Time.now.to_i
          else
            # If not a hash, wrap it in a hash to add metadata
            data[key] = { 'value' => value, 'last_accessed' => Time.now.to_i }
          end
        end
        @memory_store.write(data)
      end

      def consolidate_and_forget_memories(forgetting_threshold_days = 30)
        all_memories = read
        updated_memories = @memory_optimizer.consolidate_and_forget_memories(all_memories, forgetting_threshold_days)
        write(updated_memories)
      end

      def retrieve_contextual_memories(context, limit = 5)
        all_memories = read
        @contextual_retriever.retrieve_contextual_memories(all_memories, context, limit)
      end

      def learn_from_memories
        all_memories = read
        @memory_optimizer.learn_from_memories(all_memories)
      end
    end
  end
end
