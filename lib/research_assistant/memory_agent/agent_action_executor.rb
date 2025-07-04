module ResearchAssistant
  module MemoryAgent
    class AgentActionExecutor

      attr_reader :insights_extractor, :concept_extractor, :gap_detector, :questions_engine, :relations_finder, :generic_command, :memory_manager

      def initialize(insights_extractor:, concept_extractor:, gap_detector:, questions_engine:, relations_finder:, generic_command:, memory_manager:)
        @insights_extractor = insights_extractor
        @concept_extractor = concept_extractor
        @gap_detector = gap_detector
        @questions_engine = questions_engine
        @relations_finder = relations_finder
        @generic_command = generic_command
        @memory_manager = memory_manager
      end


      def run(action, topic, article)
        case action.name
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
        when "add_concept"
          kg = memory_manager.read
          kg.add_concept(action.value)
          memory_manager.write(kg)
          "Added concept: #{action.value}"
        when "add_relationship"
          kg = memory_manager.read
          kg.add_relationship(action.key, action.value, action.reasons)
          memory_manager.write(kg)
          "Added relationship: #{action.key} -> #{action.value} (#{action.reasons})"
        when "find_related_concepts"
          kg = memory_manager.read
          kg.find_related_concepts(action.value)
        else
          generic_command.extract(topic + " " + action.to_command, article)
        end
      end
    end
  end
end