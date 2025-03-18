module ResearchAssistant
  module Agent
    class AgentActionExecutor

      attr_reader :insights_extractor, :concept_extractor, :gap_detector, :questions_engine, :relations_finder

      def initialize(insights_extractor:, concept_extractor:, gap_detector:, questions_engine:, relations_finder:)
        @insights_extractor = insights_extractor
        @concept_extractor = concept_extractor
        @gap_detector = gap_detector
        @questions_engine = questions_engine
        @relations_finder = relations_finder
      end


      def run(action, topic, article)
        case action
        when "extract_insights"
          insights_extractor.extract(topic, article)
        when "extract_concepts"
          concept_extractor.extract(topic, article)
        when "detect_gaps"
          gap_detector.extract(topic, article)
        when "generate_questions"
          questions_engine.extract(topic, article)
        when "find_relations"
          relations_finder.extract(topic, article)
        else
           "Unknown action: #{action}"
        end
      end
    end
  end
end