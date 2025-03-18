require 'spec_helper'

RSpec.describe ResearchAssistant::Agent::ActionDeterminer do
  let(:json_api_client) { instance_double(ResearchAssistant::OllamaInterface::JsonApiClient) }
  let(:action_determiner) { described_class.new(json_api_client) }
  let(:article) { "This is a sample article content." }
  let(:action_history) { ["extract_insights", "detect_gaps"] }
  let(:input) do
    {
      article: article,
      action_history: action_history
    }
  end
  let(:response) do
    {
      "action" => "generate_questions",
      "reasons" => "The article lacks clarity on key points, so generating questions will help refine it."
    }
  end

  before do
    allow(json_api_client).to receive(:query).with(input.to_s, described_class::SCHEME).and_return(response)
  end

  describe '#get_next_action' do
    it 'returns the next action and updates the action history' do
      # Add initial actions to the history
      action_determiner.action_history.concat(action_history)

      # Call the method
      action = action_determiner.get_next_action(article)

      # Expectations
      expect(action.name).to eq("generate_questions")
      expect(action.reasons).to eq("The article lacks clarity on key points, so generating questions will help refine it.")
      expect(action_determiner.action_history).to include("generate_questions")
      expect(json_api_client).to have_received(:query).with(input.to_s, described_class::SCHEME)
    end
  end
end