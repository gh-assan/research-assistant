module ResearchAssistant
  module StoryAgent
    class AgentManager
      include SmartProperties

      attr_reader :file_manager, :termination_evaluator, :story_enhancer, :action_determiner, :agent_action_executor

      def initialize(json_api_client, writer_api_client, story_id, agent_action_executor)
        @file_manager ||= FileManager.new(story_id)
        @termination_evaluator ||= TerminationEvaluator.new
        @story_enhancer ||= StoryEnhancer.new(writer_api_client)
        @action_determiner ||= ActionDeterminer.new(json_api_client)
        @agent_action_executor ||= agent_action_executor
      end

      def run(topic, generated_story)
        iteration_number = 1
        story = generated_story
        until termination_evaluator.should_terminate?(iteration_number)

          action = action_determiner.get_next_action(story)

          pp "iteration : #{iteration_number} started action execution: #{action.name}"
          story = agent_action_executor.run(action, topic, story)
          pp "iteration : #{iteration_number} finished action execution: #{action.name}"

          # Save iteration data
          file_manager.save_iteration(story, iteration_number, action)

          pp "iteration : #{iteration_number} data saved"

          iteration_number = iteration_number + 1

        end
        story
      end
    end
  end
end