module ResearchAssistant
  module StoryAgent
    class AgentActionExecutor

      attr_reader :generic_command

      def initialize(generic_command:)
        @generic_command = generic_command
      end


      def run(action, topic, story)
        case action.name
        when "extract_insights"
          "Insights extracted"
        else
          generic_command.execute(topic, story, action)
        end
      end
    end
  end
end