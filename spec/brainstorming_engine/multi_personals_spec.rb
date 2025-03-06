require 'spec_helper'

RSpec.describe ResearchAssistant::BrainstormingEngine::MultiPersonals do
  let(:brainstorming_api_client) { instance_double(ResearchAssistant::OllamaInterface::BrainstormingClient) }
  let(:multi_personals) { described_class.new(brainstorming_api_client) }
  let(:topic) { "The impact of artificial intelligence on society" }

  describe '#run' do
    it 'formats the prompt with the given topic and queries the reasoning API client' do
      expect(brainstorming_api_client).to receive(:brainstorm).and_return("response")

      response = multi_personals.run(topic)
      expect(response).to eq("response")
    end
  end
end