require 'spec_helper'

RSpec.describe ResearchAssistant::StoryAgent::ActionDeterminer do
  let(:json_api_client) { instance_double(ResearchAssistant::OllamaInterface::JsonApiClient) }
  let(:action_determiner) { described_class.new(json_api_client) }
  let(:story) { "This is a sample story content." }
  let(:action_history) { ["generate_outline", "refine_story"] }
  let(:input) do
    {
      story: story,
      action_history: action_history
    }
  end
  let(:response) do
    {
      "action" => "enhance_story",
      "reasons" => "The story needs more depth and character development."
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
      action = action_determiner.get_next_action(story)

      # Expectations
      expect(action.name).to eq("enhance_story")
      expect(action.reasons).to eq("The story needs more depth and character development.")
      expect(action_determiner.action_history).to include("enhance_story")
      expect(json_api_client).to have_received(:query).with(input.to_s, described_class::SCHEME)
    end
  end
end