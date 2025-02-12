module ResearchAssistant
  module CoreEngine
    class FocusPrioritizer
      def prioritize(analysis)
        # Prioritize areas with the most unresolved questions or gaps
        analysis[:knowledge_gaps].sort_by { |gap| -gap[:priority] }.map { |gap| gap[:area] }
      end
    end
  end
end