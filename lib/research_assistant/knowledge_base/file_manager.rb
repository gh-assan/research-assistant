module ResearchAssistant
  module KnowledgeBase
    class FileManager
      def initialize(research_id)
        @research_id = research_id
        @base_path = File.join(ResearchAssistant.config.research_dir, research_id)
        FileUtils.mkdir_p(@base_path)
      end

      def save_analysis(analysis)
        File.write(File.join(@base_path, 'analysis.json'), JSON.pretty_generate(analysis))
      end

      def save_iteration(iteration_number, data)
        iteration_dir = File.join(@base_path, "iterations/#{iteration_number}")
        FileUtils.mkdir_p(iteration_dir)
        File.write(File.join(iteration_dir, 'data.json'), JSON.pretty_generate(data))
      end
    end
  end
end