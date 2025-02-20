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

        # Save article to .md file
        article = knowledge.article
        
        File.write(File.join(iteration_dir, "article.md"), article)

        # Save remaining data to .json file
        File.write(File.join(iteration_dir, 'questions.json'), JSON.pretty_generate(knowledge.questions))
        File.write(File.join(iteration_dir, 'concepts.json'), JSON.pretty_generate(knowledge.concepts))
        File.write(File.join(iteration_dir, 'insights.json'), JSON.pretty_generate(knowledge.insights))
        File.write(File.join(iteration_dir, 'knowledge_gaps.json'), JSON.pretty_generate(knowledge.knowledge_gaps))
        File.write(File.join(iteration_dir, 'relations.json'), JSON.pretty_generate(knowledge.relations))

        pp "Iteration data saved to #{iteration_dir}"
      end
    end
  end
end