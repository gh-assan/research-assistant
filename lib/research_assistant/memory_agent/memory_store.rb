require 'json'
require 'fileutils'

module ResearchAssistant
  module MemoryAgent
    class MemoryStore
      def initialize(memory_file_path)
        @memory_file = memory_file_path
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
        write({})
      end
    end
  end
end
