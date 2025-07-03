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
        when "add_to_memory"
          memory = memory_manager.read
          memory[action.key] = action.value
          memory_manager.write(memory)
          "Added to memory: #{action.key} -> #{action.value}"
        when "update_memory"
          memory = memory_manager.read
          memory[action.key] = action.value
          memory_manager.write(memory)
          "Updated memory: #{action.key} -> #{action.value}"
        when "read_memory"
          memory = memory_manager.read
          memory[action.key]
        else
          generic_command.extract(topic + " " + action.to_command, article)
        end
      end
    end
  end
end