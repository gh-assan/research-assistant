module ResearchAssistant
  module CoreEngine
    class FeedbackSystem
      def initialize
        @performance_metrics = { iterations: 0, questions_generated: 0, insights_found: 0 }
      end

      def update(analysis, iteration_number)
        @performance_metrics[:iterations] = iteration_number
        @performance_metrics[:questions_generated] += analysis[:questions].size
        @performance_metrics[:insights_found] += analysis[:insights].size
      end

      def adaptive_learning
        # Adjust parameters based on performance metrics
        if @performance_metrics[:insights_found] < 5
          { depth_adjustment: 1, focus_shift: "broader" }
        else
          { depth_adjustment: -1, focus_shift: "narrower" }
        end
      end
    end
  end
end