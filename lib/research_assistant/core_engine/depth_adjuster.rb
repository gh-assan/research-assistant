module ResearchAssistant
  module CoreEngine
    class DepthAdjuster
      def adjust_depth(analysis, iteration_number)
        # Increase depth gradually, but cap at a maximum
        [iteration_number, 5].min
      end
    end
  end
end