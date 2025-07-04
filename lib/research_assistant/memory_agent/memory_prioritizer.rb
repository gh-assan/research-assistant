module ResearchAssistant
  module MemoryAgent
    class MemoryPrioritizer
      def initialize(memory_manager)
        @memory_manager = memory_manager
      end

      def prioritize_memories(research_goals)
        memories = @memory_manager.read
        scored_memories = memories.map do |key, value|
          score = calculate_score(value, research_goals)
          { key: key, value: value, score: score }
        end

        scored_memories.sort_by { |memory| -memory[:score] }
      end

      private

      def calculate_score(memory, research_goals)
        relevance = memory.to_s.downcase.include?(research_goals.downcase) ? 10 : 0
        importance = memory.is_a?(Hash) && memory['importance'] ? memory['importance'] : 0
        recency = memory.is_a?(Hash) && memory['last_accessed'] ? Time.now.to_i - memory['last_accessed'] : 0

        relevance + importance - recency
      end
    end
  end
end
