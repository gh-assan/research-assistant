require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::IterationManager do
  let(:mock_api_client) { instance_double('ResearchAssistant::OllamaInterface::ApiClient') }
  let(:mock_file_manager) { instance_double('ResearchAssistant::KnowledgeBase::FileManager') }
  let(:mock_question_engine) { instance_double('ResearchAssistant::CoreEngine::QuestionEngine') }
  let(:mock_progress_tracker) { instance_double('ResearchAssistant::CoreEngine::ProgressTracker') }
  let(:mock_depth_adjuster) { instance_double('ResearchAssistant::CoreEngine::DepthAdjuster') }
  let(:mock_focus_prioritizer) { instance_double('ResearchAssistant::CoreEngine::FocusPrioritizer') }
  let(:mock_termination_evaluator) { instance_double('ResearchAssistant::CoreEngine::TerminationEvaluator') }
  let(:mock_feedback_system) { instance_double('ResearchAssistant::CoreEngine::FeedbackSystem') }
  let(:mock_response_analyzer) { instance_double('ResearchAssistant::CoreEngine::InsightsExtractor') }
  let(:mock_concept_extractor) { instance_double('ResearchAssistant::CoreEngine::ConceptExtractor') }
  let(:mock_concept_updater) { instance_double('ResearchAssistant::CoreEngine::ConceptUpdater') }
  let(:mock_gap_detector) { instance_double('ResearchAssistant::CoreEngine::GapDetector') }
  let(:mock_knowledge_integrator) { instance_double('ResearchAssistant::CoreEngine::KnowledgeIntegrator') }

  let(:iteration_manager) do
    described_class.new(
      api_client: mock_api_client,
      file_manager: mock_file_manager,
      question_engine: mock_question_engine,
      progress_tracker: mock_progress_tracker,
      depth_adjuster: mock_depth_adjuster,
      focus_prioritizer: mock_focus_prioritizer,
      termination_evaluator: mock_termination_evaluator,
      feedback_system: mock_feedback_system,
      knowledge_integrator: mock_knowledge_integrator
    )
  end

  describe '#run' do
    it 'runs the iteration process until termination condition is met' do
      analysis = { insights: [], core_concepts: [], knowledge_gaps: [] }
      iteration_number = 1
      depth_level = 2
      focus_areas = ['Area 1', 'Area 2']
      questions = ['Question 1', 'Question 2']
      responses = ['Response 1', 'Response 2']

      allow(mock_termination_evaluator).to receive(:should_terminate?).and_return(false, true)
      allow(mock_progress_tracker).to receive(:next_iteration).and_return(iteration_number)
      allow(mock_depth_adjuster).to receive(:adjust_depth).and_return(depth_level)
      allow(mock_focus_prioritizer).to receive(:prioritize).and_return(focus_areas)
      allow(mock_question_engine).to receive(:generate_questions).and_return(questions)
      allow(mock_api_client).to receive(:query).and_return(*responses)
      allow(mock_knowledge_integrator).to receive(:integrate).and_return(analysis)
      allow(mock_file_manager).to receive(:save_iteration)
      allow(mock_feedback_system).to receive(:update)

      iteration_manager.run(analysis)

      expect(mock_termination_evaluator).to have_received(:should_terminate?).twice
      expect(mock_progress_tracker).to have_received(:next_iteration).once
      expect(mock_depth_adjuster).to have_received(:adjust_depth).once
      expect(mock_focus_prioritizer).to have_received(:prioritize).once
      expect(mock_question_engine).to have_received(:generate_questions).once
      expect(mock_api_client).to have_received(:query).twice
      expect(mock_knowledge_integrator).to have_received(:integrate).once
      expect(mock_file_manager).to have_received(:save_iteration).once
      expect(mock_feedback_system).to have_received(:update).once
    end
  end
end