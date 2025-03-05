require 'spec_helper'

RSpec.describe ResearchAssistant::BrainstormingEngine::IterationManager do
  let(:brainstorming_integrator) { instance_double(ResearchAssistant::BrainstormingEngine::BrainstormingIntegrator) }
  let(:brainstorming_file_manager) { instance_double(ResearchAssistant::KnowledgeBase::BrainstormingFileManager) }
  let(:summary_generator) { instance_double(ResearchAssistant::Output::SummaryGenerator) }
  let(:termination_evaluator) { instance_double(ResearchAssistant::CoreEngine::TerminationEvaluator) }
  let(:research_id) { SecureRandom.uuid }
  let(:iteration_manager) do
    described_class.new(
      brainstorming_integrator,
      brainstorming_file_manager,
      summary_generator,
      termination_evaluator,
      research_id
    )
  end
  let(:topic) { "The impact of artificial intelligence on society" }
  let(:last_round_summary) { "Summary of the last round" }
  let(:brainstorming_data) { instance_double(ResearchAssistant::KnowledgeBase::BrainstormingData, summary: nil) }
  let(:summary) { "Generated summary" }

  describe '#run' do
    it 'runs brainstorming iterations and saves the results' do
      allow(brainstorming_integrator).to receive(:integrate).and_return(brainstorming_data)
      # allow(brainstorming_integrator).to receive(:integrate).with(topic, 2, last_round_summary).and_return(brainstorming_data)
      allow(summary_generator).to receive(:generate_summary).with(brainstorming_data).and_return(summary)
      allow(brainstorming_file_manager).to receive(:save_iteration)
      # allow(brainstorming_file_manager).to receive(:save_iteration).with(brainstorming_data, 2)
      allow(termination_evaluator).to receive(:should_terminate?).and_return(false, true)

      expect(brainstorming_data).to receive(:summary=).with(summary).twice

      iteration_manager.run(topic, last_round_summary)

      expect(brainstorming_integrator).to have_received(:integrate).with(topic, 1, last_round_summary)
      expect(brainstorming_integrator).to have_received(:integrate).with(topic, 2, last_round_summary)
      expect(summary_generator).to have_received(:generate_summary).with(brainstorming_data).twice
      expect(brainstorming_file_manager).to have_received(:save_iteration).with(brainstorming_data, 1)
      expect(brainstorming_file_manager).to have_received(:save_iteration).with(brainstorming_data, 2)
      expect(termination_evaluator).to have_received(:should_terminate?).twice
    end
  end
end