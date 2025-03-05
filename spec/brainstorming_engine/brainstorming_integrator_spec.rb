require 'spec_helper'

RSpec.describe ResearchAssistant::BrainstormingEngine::BrainstormingIntegrator do
  let(:multi_personals) { instance_double(ResearchAssistant::BrainstormingEngine::MultiPersonals) }
  let(:deep_dive) { instance_double(ResearchAssistant::BrainstormingEngine::DeepDive) }
  let(:reverse_brainstorming) { instance_double(ResearchAssistant::BrainstormingEngine::ReverseBrainstorming) }
  let(:future_vision) { instance_double(ResearchAssistant::BrainstormingEngine::FutureVision) }
  let(:mind_mapping) { instance_double(ResearchAssistant::BrainstormingEngine::MindMapping) }
  let(:scamper_method) { instance_double(ResearchAssistant::BrainstormingEngine::ScamperMethod) }
  let(:brainstorming_integrator) do
    described_class.new(
      multi_personals: multi_personals,
      deep_dive: deep_dive,
      reverse_brainstorming: reverse_brainstorming,
      future_vision: future_vision,
      mind_mapping: mind_mapping,
      scamper_method: scamper_method
    )
  end
  let(:topic) { "The impact of artificial intelligence on society" }
  let(:iteration_number) { 1 }
  let(:last_round_summary) { "Summary of the last round" }

  describe '#integrate' do
    it 'integrates results from all brainstorming methods' do
      allow(multi_personals).to receive(:run).with(topic, last_round_summary).and_return("multi_personals_results")
      allow(deep_dive).to receive(:run).with(topic, last_round_summary).and_return("deep_dive_results")
      allow(reverse_brainstorming).to receive(:run).with(topic, last_round_summary).and_return("reverse_brainstorming_results")
      allow(future_vision).to receive(:run).with(topic, last_round_summary).and_return("future_vision_results")
      allow(mind_mapping).to receive(:run).with(topic, last_round_summary).and_return("mind_mapping_results")
      allow(scamper_method).to receive(:run).with(topic, last_round_summary).and_return("scamper_results")

      brainstorming_data = brainstorming_integrator.integrate(topic, iteration_number, last_round_summary)

      expect(brainstorming_data.multi_personals).to eq("multi_personals_results")
      expect(brainstorming_data.deep_dive).to eq("deep_dive_results")
      expect(brainstorming_data.reverse_brainstorming).to eq("reverse_brainstorming_results")
      expect(brainstorming_data.future_vision).to eq("future_vision_results")
      expect(brainstorming_data.mind_mapping).to eq("mind_mapping_results")
      expect(brainstorming_data.scamper_method).to eq("scamper_results")
      expect(brainstorming_data.topic).to eq(topic)
      expect(brainstorming_data.last_round_summary).to eq(last_round_summary)
    end
  end
end