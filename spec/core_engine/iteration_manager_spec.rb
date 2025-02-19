require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::IterationManager do
  let(:mock_api_client) { instance_double('ResearchAssistant::OllamaInterface::ApiClient') }
  let(:mock_json_api_client) { instance_double('ResearchAssistant::OllamaInterface::JsonApiClient') }
  let(:mock_writer_api_client) { instance_double('ResearchAssistant::OllamaInterface::WriterApiClient') }
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
    described_class.new(mock_api_client, mock_json_api_client, mock_writer_api_client)
  end

  describe '#run' do
    it 'runs the iteration process until termination condition is met' do
      iteration_manager.termination_evaluator = mock_termination_evaluator
      iteration_manager.knowledge_integrator = mock_knowledge_integrator

      knowledge = ResearchAssistant::KnowledgeBase::Knowledge.new
      iteration_number = 1
      depth_level = 2
      focus_areas = ['Area 1', 'Area 2']
      questions = ['Question 1', 'Question 2']
      responses = ['Response 1', 'Response 2']
      article = 'Article 1'

      allow(mock_termination_evaluator).to receive(:should_terminate?).and_return(false, true)
      allow(mock_progress_tracker).to receive(:next_iteration).and_return(iteration_number)
      allow(mock_depth_adjuster).to receive(:adjust_depth).and_return(depth_level)
      allow(mock_focus_prioritizer).to receive(:prioritize).and_return(focus_areas)
      allow(mock_question_engine).to receive(:extract).and_return(questions)
      allow(mock_api_client).to receive(:query).and_return(*responses)
      allow(mock_json_api_client).to receive(:query).and_return(*responses)
      allow(mock_writer_api_client).to receive(:write_article).and_return(article)
      allow(mock_knowledge_integrator).to receive(:integrate).and_return(knowledge)
      allow(mock_file_manager).to receive(:save_iteration)
      allow(mock_feedback_system).to receive(:update)

      iteration_manager.run(knowledge)

      expect(mock_termination_evaluator).to have_received(:should_terminate?).twice
      expect(mock_knowledge_integrator).to have_received(:integrate).once

    end
  end
end