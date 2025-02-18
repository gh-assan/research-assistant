module ResearchAssistant
  module CoreEngine
    class IterationManager
      include SmartProperties

      property :api_client
      property :file_manager
      property :question_engine
      property :progress_tracker
      property :depth_adjuster
      property :focus_prioritizer
      property :termination_evaluator
      property :feedback_system
      property :knowledge_integrator

      def initialize(**args)
        super
        @progress_tracker ||= ProgressTracker.new
        @depth_adjuster ||= DepthAdjuster.new
        @focus_prioritizer ||= FocusPrioritizer.new
        @termination_evaluator ||= TerminationEvaluator.new
        @feedback_system ||= FeedbackSystem.new
        @knowledge_integrator ||= KnowledgeIntegrator.new(
          response_analyzer: InsightsExtractor.new(api_client),
          concept_updater: ConceptUpdater.new(ConceptExtractor.new(api_client)),
          gap_detector: GapDetector.new(api_client)
        )
      end

      def run(analysis)
        until termination_evaluator.should_terminate?(analysis)
          iteration_number = progress_tracker.next_iteration
          depth_level = depth_adjuster.adjust_depth(analysis, iteration_number)
          focus_areas = focus_prioritizer.prioritize(analysis)

          # Generate and execute questions
          questions = question_engine.generate_questions(analysis)
          responses = questions.map { |q| api_client.query(q) }

          # Integrate knowledge
          analysis = knowledge_integrator.integrate(analysis, responses)

          # Save iteration data
          file_manager.save_iteration(iteration_number, { questions: questions, responses: responses })

          # Update feedback system
          feedback_system.update(analysis, iteration_number)
        end
      end
    end
  end
end