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
