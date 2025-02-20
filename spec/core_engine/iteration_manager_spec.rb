# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::IterationManager do
  let(:api_client) { instance_double(ResearchAssistant::OllamaInterface::ApiClient) }
  let(:json_api_client) { instance_double(ResearchAssistant::OllamaInterface::JsonApiClient) }
  let(:writer_api_client) { instance_double(ResearchAssistant::OllamaInterface::WriterApiClient) }
  let(:file_manager) { instance_double(ResearchAssistant::KnowledgeBase::FileManager) }
  let(:termination_evaluator) { instance_double(ResearchAssistant::CoreEngine::TerminationEvaluator) }
  let(:output_generator) { instance_double(ResearchAssistant::Output::OutputGenerator) }
  let(:knowledge_integrator) { instance_double(ResearchAssistant::CoreEngine::KnowledgeIntegrator) }
  let(:feedback_system) { instance_double(ResearchAssistant::CoreEngine::FeedbackSystem) }
  let(:progress_tracker) { instance_double(ResearchAssistant::CoreEngine::ProgressTracker) }
  let(:depth_adjuster) { instance_double(ResearchAssistant::CoreEngine::DepthAdjuster) }
  let(:focus_prioritizer) { instance_double(ResearchAssistant::CoreEngine::FocusPrioritizer) }
  let(:research_id) { 'sample_research_id' }
  let(:knowledge) do
    ResearchAssistant::KnowledgeBase::Knowledge.new(
      insights: [],
      concepts: [],
      relations: [],
      knowledge_gaps: [],
      questions: [],
      article: 'Initial article content.',
      last_round_article: 'Last round article content.',
      user_intent: 'To understand the topic.',
      topic: 'Sample Topic',
      iteration: 1
    )
  end

  let(:iteration_manager) do
    described_class.new(api_client, json_api_client, writer_api_client, research_id).tap do |manager|
      manager.file_manager = file_manager
      manager.termination_evaluator = termination_evaluator
      manager.output_generator = output_generator
      manager.knowledge_integrator = knowledge_integrator
      manager.feedback_system = feedback_system
      manager.progress_tracker = progress_tracker
      manager.depth_adjuster = depth_adjuster
      manager.focus_prioritizer = focus_prioritizer
    end
  end

  describe '#run' do
    context 'when the termination condition is met' do
      it 'runs the iterations and returns the final knowledge' do
        allow(termination_evaluator).to receive(:should_terminate?).and_return(false, true)
        allow(knowledge_integrator).to receive(:integrate).and_return(knowledge)
        allow(output_generator).to receive(:generate_article).and_return('Generated article content.')
        allow(file_manager).to receive(:save_iteration)

        final_knowledge = iteration_manager.run(knowledge)

        expect(final_knowledge.article).to eq('Generated article content.')
        expect(knowledge_integrator).to have_received(:integrate).once
        expect(output_generator).to have_received(:generate_article).once
        expect(file_manager).to have_received(:save_iteration).once
      end
    end

    context 'when the termination condition is not met' do
      it 'runs multiple iterations and returns the final knowledge' do
        allow(termination_evaluator).to receive(:should_terminate?).and_return(false, false, true)
        allow(knowledge_integrator).to receive(:integrate).and_return(knowledge)
        allow(output_generator).to receive(:generate_article).and_return('Generated article content.')
        allow(file_manager).to receive(:save_iteration)

        final_knowledge = iteration_manager.run(knowledge)

        expect(final_knowledge.article).to eq('Generated article content.')
        expect(knowledge_integrator).to have_received(:integrate).twice
        expect(output_generator).to have_received(:generate_article).twice
        expect(file_manager).to have_received(:save_iteration).twice
      end
    end
  end
end