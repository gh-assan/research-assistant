module ResearchAssistant
  module CoreEngine
    class ProgressTracker
      def initialize
        @current_iteration = 0
      end

      def next_iteration
        @current_iteration += 1
      end

      def current_iteration
        @current_iteration
      end
    end
  end
end