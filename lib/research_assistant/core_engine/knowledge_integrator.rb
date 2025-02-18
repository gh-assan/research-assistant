module ResearchAssistant
  module CoreEngine
    class KnowledgeIntegrator
      attr_reader :insights_extractor, :concept_extractor, :gap_detector

      def initialize(insights_extractor:, concept_extractor:, gap_detector:)
        @insights_extractor = insights_extractor
        @concept_extractor = concept_extractor
        @gap_detector = gap_detector
      end

      def integrate(analysis, topic, response)
        insights = insights_extractor.analyze(topic, response)
        concepts = concept_extractor.extract(topic, response)
        gaps = gap_detector.detect(analysis, response)

        knowledge = ResearchAssistant::KnowledgeBase::Knowledge.new
        knowledge.insights = insights
        knowledge.concepts = concepts
        knowledge.knowledge_gaps = gaps

        knowledge
      end
    end
  end
end