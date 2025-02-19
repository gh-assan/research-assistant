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
        insights = insights_extractor.analyze(topic, last_round_article)
        concepts = concept_extractor.extract(topic, last_round_article)
        gaps = gap_detector.detect(insights, last_round_article)
        questions = questions_engine.extract(last_round_article)
        relations = relations_finder.find_relations(topic, last_round_article, insights)

        knowledge = ResearchAssistant::KnowledgeBase::Knowledge.new
        knowledge.insights = insights['insights'] unless insights['insights'].nil?
        knowledge.concepts = concepts['concepts'] unless concepts['concepts'].nil?
        knowledge.knowledge_gaps = gaps['knowledge_gaps'] unless gaps['knowledge_gaps'].nil?
        knowledge.questions = questions['questions'] unless questions['questions'].nil?
        knowledge.relations = relations['relations'] unless relations['relations'].nil?
        knowledge.user_intent = user_intent
        knowledge.iteration = iteration_number
        knowledge.last_round_article = last_round_article
        knowledge.topic = topic

        pp "article: #{knowledge.article}"
        knowledge
      end
    end
  end
end