require 'json'

module ResearchAssistant
  module MemoryAgent
    class MemoryManager
      def initialize(research_id)
        @base_path = File.join(ResearchAssistant.config.research_dir, research_id)
        @memory_file = File.join(@base_path, 'memory.json')
        pp "MemoryManager: Initializing memory file: #{@memory_file}"
        initialize_memory_file
      end

      def read
        JSON.parse(File.read(@memory_file))
      rescue Errno::ENOENT, JSON::ParserError
        {}
      end

      def write(data)
        File.write(@memory_file, JSON.pretty_generate(data))
      end

      def retrieve_contextual_memories(context, limit = 5)
        all_memories = read
        relevant_memories = []

        context_keywords = extract_keywords_from_context(context)

        significant_context_keywords = context_keywords.select { |k| k.length > 3 }

        all_memories.each do |key, value|
          if significant_context_keywords.any? { |keyword| value.to_s.downcase.include?(keyword.downcase) }
            relevant_memories << { key: key, value: value }
          end
        end

        # For now, a simple relevance ranking (e.g., based on number of keyword matches)
        # This can be improved with more sophisticated ranking algorithms later.
        relevant_memories.sort_by! do |memory|
          score = 0
          context_keywords.each do |keyword|
            score += 1 if memory[:value].to_s.downcase.include?(keyword.downcase)
          end
          -score # Sort in descending order of score
        end

        relevant_memories.take(limit)
      end

      private

      def extract_keywords_from_context(context)
        # This is a basic keyword extraction. Can be enhanced with NLP techniques.
        context.to_s.downcase.scan(/\b[a-z0-9]+\b/).uniq
      end

      private

      def initialize_memory_file
        return if File.exist?(@memory_file)

        FileUtils.mkdir_p(File.dirname(@memory_file))
        pp "MemoryManager: Directory created/exists for memory file: #{File.directory?(File.dirname(@memory_file))}"
        write({})
      end
    end
  end
end
