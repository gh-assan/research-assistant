module ResearchAssistant
  module CoreEngine
    class IterationManager
      include SmartProperties

      property :file_manager
      property :progress_tracker
      property :depth_adjuster
      property :focus_prioritizer
      property :termination_evaluator
      property :knowledge_integrator
      property :output_generator

      def initialize(reasoning_api_client, json_api_client, writer_api_client, research_id)
        @file_manager ||= ResearchAssistant::KnowledgeBase::FileManager.new(research_id)
        @termination_evaluator ||= TerminationEvaluator.new(reasoning_api_client, json_api_client)
        @output_generator ||= ResearchAssistant::Output::OutputGenerator.new(writer_api_client)
        @knowledge_integrator ||= KnowledgeIntegrator.new(
          insights_extractor: InsightsExtractor.new(reasoning_api_client, json_api_client),
          concept_extractor: ConceptExtractor.new(reasoning_api_client, json_api_client),
          gap_detector: GapDetector.new(reasoning_api_client, json_api_client),
          questions_engine: QuestionEngine.new(reasoning_api_client, json_api_client),
          relations_finder: RelationsFinder.new(reasoning_api_client, json_api_client)
        )
      end

      def run(knowledge)
        round_knowledge = knowledge
        iteration_number = 1
        until termination_evaluator.should_terminate?(round_knowledge)

          # Integrate knowledge
          round_knowledge = knowledge_integrator.integrate(round_knowledge.topic, round_knowledge.article, round_knowledge.user_intent, iteration_number)

          iteration_number = iteration_number + 1

          article = output_generator.generate_article(round_knowledge)

          round_knowledge.article = article

          pp "iteration : #{round_knowledge.iteration}"

          # Save iteration data
          file_manager.save_iteration(round_knowledge)

          # Update feedback system
          # feedback_system.update(analysis, iteration_number)
        end
        round_knowledge
      end
    end
  end
end