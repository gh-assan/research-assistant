require 'spec_helper'

RSpec.describe ResearchAssistant::BrainstormingEngine::MultiPersonals do
  let(:reasoning_api_client) { instance_double(ResearchAssistant::OllamaInterface::ReasoningClient) }
  let(:multi_personals) { described_class.new(reasoning_api_client) }
  let(:topic) { "The impact of artificial intelligence on society" }

  describe '#run' do
    it 'formats the prompt with the given topic and queries the reasoning API client' do
      expect(reasoning_api_client).to receive(:query).and_return("response")

      response = multi_personals.run(topic)
      expect(response).to eq("response")
    end
  end
end