require 'spec_helper'

RSpec.describe ResearchAssistant::BrainstormingEngine::FutureVision do
  let(:brainstorming_api_client) { instance_double(ResearchAssistant::OllamaInterface::BrainstormingClient) }
  let(:future_vision) { described_class.new(brainstorming_api_client) }
  let(:topic) { "The impact of artificial intelligence on society" }

  describe '#run' do
    it 'formats the prompt with the given topic and queries the reasoning API client' do
      expect(brainstorming_api_client).to receive(:brainstorm).and_return("response")

      response = future_vision.run(topic)
      expect(response).to eq("response")
    end
  end
end