module ResearchAssistant
  module MemoryAgent
    class FileManager
      attr_reader :memory_manager

      def initialize(research_id)
        @research_id = research_id
        @base_path = File.join(ResearchAssistant.config.research_dir, research_id)
        pp "FileManager: Creating directory: #{@base_path}"
        FileUtils.mkdir_p(@base_path)
        pp "FileManager: Directory created/exists: #{File.directory?(@base_path)}"
        @memory_manager = MemoryManager.new(research_id)
      end

      def save_iteration(article, iteration, actions, analysis_outputs)
        iteration_dir = File.join(@base_path, "iterations/#{iteration}")
        FileUtils.mkdir_p(iteration_dir)

        File.write(File.join(iteration_dir, "article.md"), article)

        File.write(File.join(iteration_dir, 'actions.md'), actions.map(&:to_command).join("\n\n"))
        File.write(File.join(iteration_dir, 'analysis_outputs.md'), analysis_outputs.join("\n\n"))

        pp "Iteration data saved to #{iteration_dir}"
      end
    end
  end
end