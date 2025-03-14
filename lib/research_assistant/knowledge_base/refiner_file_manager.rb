module ResearchAssistant
  module KnowledgeBase
    class RefinerFileManager
      def initialize(research_id)
        @research_id = research_id
        @base_path = File.join(ResearchAssistant.config.research_dir, research_id)
        FileUtils.mkdir_p(@base_path)
      end

      def save_iteration(article, review, iteration_number)
        iteration_dir = File.join(@base_path, "iterations/#{iteration_number}")
        FileUtils.mkdir_p(iteration_dir)

        # Save article to .md file
        File.write(File.join(iteration_dir, "refined_article.md"), article)
        File.write(File.join(iteration_dir, "review.md"), review)

        pp "Iteration data saved to #{iteration_dir}"
      end
    end
  end
end