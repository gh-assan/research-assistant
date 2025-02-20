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

      def integrate(topic, last_round_article, user_intent, iteration_number)
        pp "KnowledgeIntegrator start integrating knowledge for iteration #{iteration_number}"

        input_article = last_round_article || user_intent
        insights = insights_extractor.analyze(topic, input_article)
        concepts = concept_extractor.extract(topic, input_article)
        gaps = gap_detector.detect(insights, input_article)
        questions = questions_engine.extract(input_article)
        relations = relations_finder.find_relations(topic, input_article, insights)

        knowledge = ResearchAssistant::KnowledgeBase::Knowledge.new
        knowledge.insights = insights
        knowledge.concepts = concepts
        knowledge.knowledge_gaps = gaps
        knowledge.questions = questions
        knowledge.relations = relations
        knowledge.user_intent = user_intent
        knowledge.iteration = iteration_number
        knowledge.last_round_article = last_round_article
        knowledge.topic = topic

        pp "KnowledgeIntegrator finished integrating knowledge for iteration #{iteration_number}"
        knowledge
      end
    end
  end
end