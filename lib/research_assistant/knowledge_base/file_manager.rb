module ResearchAssistant
  module KnowledgeBase
    class FileManager
      def initialize(research_id)
        @research_id = research_id
        @base_path = File.join(ResearchAssistant.config.research_dir, research_id)
        FileUtils.mkdir_p(@base_path)
      end

      def save_iteration(knowledge)
        iteration_dir = File.join(@base_path, "iterations/#{knowledge.iteration}")
        FileUtils.mkdir_p(iteration_dir)

        File.write(File.join(iteration_dir, "article.md"), knowledge.article)

        # Save remaining data to .json file
        File.write(File.join(iteration_dir, 'questions.md'), knowledge.questions)
        File.write(File.join(iteration_dir, 'concepts.md'), knowledge.concepts)
        File.write(File.join(iteration_dir, 'insights.md'), knowledge.insights)
        File.write(File.join(iteration_dir, 'knowledge_gaps.md'), knowledge.knowledge_gaps)
        File.write(File.join(iteration_dir, 'relations.md'), knowledge.relations)

        pp "Iteration data saved to #{iteration_dir}"
      end
    end
  end
end