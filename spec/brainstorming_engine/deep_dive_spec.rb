require 'spec_helper'

RSpec.describe ResearchAssistant::BrainstormingEngine::DeepDive do
  let(:reasoning_api_client) { instance_double(ResearchAssistant::OllamaInterface::ReasoningClient) }
  let(:deep_dive) { described_class.new(reasoning_api_client) }
  let(:topic) { "The impact of artificial intelligence on society" }


  describe '#run' do
    it 'formats the prompt with the given topic and queries the reasoning API client' do
      expect(reasoning_api_client).to receive(:query).and_return("response")

      response = deep_dive.run(topic)
      expect(response).to eq("response")
    end
  end
end