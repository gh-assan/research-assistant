module ResearchAssistant
  module MemoryAgent
    class AgentManager
      include SmartProperties

      attr_reader :file_manager, :termination_evaluator, :article_enhancer, :action_determiner, :agent_action_executor

      def initialize(json_api_client, writer_api_client, file_manager, agent_action_executor)
        pp "AgentManager#initialize: Type of file_manager: #{file_manager.class}"
        @file_manager = file_manager
        @termination_evaluator ||= TerminationEvaluator.new
        @article_enhancer ||= ArticleEnhancer.new(writer_api_client)
        @action_determiner ||= ActionDeterminer.new(json_api_client)
        @agent_action_executor ||= agent_action_executor
      end

      def run(topic, generated_article)
        iteration_number = 1
        article = generated_article
        pp "AgentManager#run: Type of @file_manager: #{@file_manager.class}"
        knowledge_graph = @file_manager.memory_manager.read

        until termination_evaluator.should_terminate?(iteration_number)
          # Use prioritized memories in decision-making
          begin
            actions = action_determiner.get_next_action(article, knowledge_graph)
          rescue => e
            pp "Error in ActionDeterminer#get_next_action: #{e.class} - #{e.message}"
            pp e.backtrace.first(10)
            # Optionally, you could log to a file or take other recovery actions here
            break # or next, or handle as appropriate
          end
          pp "AgentManager: Actions received from ActionDeterminer: #{actions.inspect}"
          all_analyses = []
          article_enhancement_analyses = []
          all_actions = []

          actions.each do |action|
            analysis = agent_action_executor.run(action, topic, article)
            all_analyses << analysis
            all_actions << action

            unless ["add_concept", "add_relationship", "find_related_concepts"].include?(action.name)
              article_enhancement_analyses << analysis
            end
            pp "iteration : #{iteration_number} executed action: #{action.name}"
          end

          article = article_enhancer.enhance(article, all_actions, article_enhancement_analyses)

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