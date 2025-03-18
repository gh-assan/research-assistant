module ResearchAssistant
  module Agent
    class FileManager
      def initialize(research_id)
        @research_id = research_id
        @base_path = File.join(ResearchAssistant.config.research_dir, research_id)
        FileUtils.mkdir_p(@base_path)
      end

      def save_iteration(article, iteration, action, analysis_output)
        iteration_dir = File.join(@base_path, "iterations/#{iteration}")
        FileUtils.mkdir_p(iteration_dir)

        File.write(File.join(iteration_dir, "article.md"), article)

        File.write(File.join(iteration_dir, 'action.md'), action)
        File.write(File.join(iteration_dir, 'analysis_output.md'), analysis_output)

        pp "Iteration data saved to #{iteration_dir}"
      end
    end
  end
end