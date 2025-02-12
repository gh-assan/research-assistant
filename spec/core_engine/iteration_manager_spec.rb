require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::IterationManager do
  let(:mock_api) { instance_double('OllamaInterface::APIClient') }
  let(:mock_file) { instance_double('KnowledgeBase::FileManager') }
  let(:mock_questions) { instance_double('QuestionEngine') }
  let(:mock_termination) { instance_double('TerminationEvaluator') }
  
  let(:manager) do
    described_class.new(
      api_client: mock_api,
      file_manager: mock_file,
      question_engine: mock_questions,
      termination_evaluator: mock_termination
    )
  end

  describe '#run' do
    it 'executes full iteration lifecycle' do
      analysis = { knowledge_gaps: [] }
      allow(mock_termination).to receive(:should_terminate?).and_return(false, true)
      allow(mock_questions).to receive(:generate_questions).and_return([])
      allow(mock_api).to receive(:query).and_return("Response")
      allow(mock_file).to receive(:save_iteration)

      manager.run(analysis)
      expect(mock_file).to have_received(:save_iteration).once
    end
  end
end