module ResearchAssistant
  module CoreEngine
    class TerminationEvaluator
      def should_terminate?(analysis)
        # Check for termination conditions
        saturation_detected?(analysis) || objectives_met?(analysis) || redundancy_detected?(analysis)
      end

      private

      def saturation_detected?(analysis)
        # Check if no new insights are being generated
        analysis[:insights].size >= 10 && analysis[:insights].last(3).uniq.size == 1
      end

      def objectives_met?(analysis)
        # Check if research objectives are met
        analysis[:knowledge_gaps].empty?
      end

      def redundancy_detected?(analysis)
        # Check for redundant iterations
        analysis[:iterations].size >= 10 && analysis[:iterations].last(3).uniq.size == 1
      end
    end
  end
end