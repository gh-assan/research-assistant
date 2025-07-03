module ResearchAssistant
  module MemoryAgent
    class AgentManager
      include SmartProperties

      attr_reader :file_manager, :termination_evaluator, :article_enhancer, :action_determiner, :agent_action_executor

      def initialize(json_api_client, writer_api_client, file_manager, agent_action_executor)
        @file_manager = file_manager
        @termination_evaluator ||= TerminationEvaluator.new
        @article_enhancer ||= ArticleEnhancer.new(writer_api_client)
        @action_determiner ||= ActionDeterminer.new(json_api_client)
        @agent_action_executor ||= agent_action_executor
      end

      def run(topic, generated_article)
        iteration_number = 1
        article = generated_article
        memory_manager = file_manager.memory_manager

        until termination_evaluator.should_terminate?(iteration_number)
          memory = memory_manager.read
          actions = action_determiner.get_next_action(article, memory)
          all_analyses = []
          all_actions = []

          actions.each do |action|
            analysis = agent_action_executor.run(action, topic, article)
            all_analyses << analysis
            all_actions << action
            pp "iteration : #{iteration_number} executed action: #{action.name}"
          end

          article = article_enhancer.enhance(article, all_actions, all_analyses)

          # Save iteration data
          file_manager.save_iteration(article, iteration_number, all_actions, all_analyses)

          pp "iteration : #{iteration_number} data saved"

          iteration_number = iteration_number + 1

        end
        article
      end
    end
  end
end