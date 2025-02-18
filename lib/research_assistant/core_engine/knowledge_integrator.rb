module ResearchAssistant
  module CoreEngine
    class KnowledgeIntegrator
      attr_reader :insights_extractor, :concept_extractor, :gap_detector, :questions_engine, :relations_finder

      def initialize(insights_extractor:, concept_extractor:, gap_detector:, questions_engine:, relations_finder:)
        @insights_extractor = insights_extractor
        @concept_extractor = concept_extractor
        @gap_detector = gap_detector
        @questions_engine = questions_engine
        @relations_finder = relations_finder
      end

      def integrate(analysis, topic, response, user_intent)
        insights = insights_extractor.analyze(topic, response)
        concepts = concept_extractor.extract(topic, response)
        gaps = gap_detector.detect(analysis, response)
        questions = questions_engine.extract(response)
        relations = relations_finder.find_relations(topic, response, analysis)

        knowledge = ResearchAssistant::KnowledgeBase::Knowledge.new
        knowledge.insights = insights['insights']
        knowledge.concepts = concepts['concepts']
        knowledge.knowledge_gaps = gaps['knowledge_gaps']
        knowledge.questions = questions['questions']
        knowledge.relations = relations['relations']
        knowledge.user_intent = user_intent

        knowledge
      end
    end
  end
end