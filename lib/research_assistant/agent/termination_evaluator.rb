module ResearchAssistant
  module Agent
    class TerminationEvaluator

      def should_terminate?(iteration)
        max_iterations_reached?(iteration)
      end

      private

      def max_iterations_reached?(iteration)
        iteration >= max_iterations
      end

      def max_iterations
        ResearchAssistant.config.max_agent_iterations
      end
    end
  end
end