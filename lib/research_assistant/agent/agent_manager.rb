module ResearchAssistant
  module Agent
    class AgentManager
      include SmartProperties

      attr_reader :file_manager, :termination_evaluator, :article_enhancer, :action_determiner, :agent_action_executor

      def initialize(json_api_client, writer_api_client, research_id, agent_action_executor)
        @file_manager ||= FileManager.new(research_id)
        @termination_evaluator ||= TerminationEvaluator.new
        @article_enhancer ||= ArticleEnhancer.new(writer_api_client)
        @action_determiner ||= ActionDeterminer.new(json_api_client)
        @agent_action_executor ||= agent_action_executor
      end

    def run(topic, generated_article)
        iteration_number =  1
        article = generated_article
        until termination_evaluator.should_terminate?(iteration_number)

          action = action_determiner.get_next_action(article)
          analysis = agent_action_executor.run(action, topic, article)

          article = article_enhancer.enhance(article, action, analysis)

          pp "iteration : #{iteration_number} executed action: #{action.name}"

          # Save iteration data
          file_manager.save_iteration(article, iteration_number, action, analysis)

          pp "iteration : #{iteration_number} data saved"

          iteration_number = iteration_number + 1

        end
        article
      end
    end
  end
end