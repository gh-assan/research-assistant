module ResearchAssistant
  module CoreEngine
    class KnowledgeIntegrator
      attr_reader :response_analyzer, :concept_updater, :gap_detector

      def initialize(response_analyzer:, concept_updater:, gap_detector:)
        @response_analyzer = response_analyzer
        @concept_updater = concept_updater
        @gap_detector = gap_detector
      end

      def integrate(analysis, responses)
        responses.each do |response|
          analysis = response_analyzer.analyze(response, analysis)
          analysis = concept_updater.update(analysis, response)
          gaps = gap_detector.detect(analysis, response)
          analysis[:knowledge_gaps] ||= []
          analysis[:knowledge_gaps] += gaps
        end
        analysis
      end
    end
  end
end