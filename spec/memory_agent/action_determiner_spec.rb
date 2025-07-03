require 'spec_helper'

RSpec.describe ResearchAssistant::MemoryAgent::ActionDeterminer do
  let(:json_api_client) { instance_double(ResearchAssistant::OllamaInterface::JsonApiClient) }
  let(:action_determiner) { described_class.new(json_api_client) }

  describe "#get_next_action" do
    let(:article) { "Test article content" }
    let(:memory) { { "key" => "value" } }
    let(:llm_response) do
      [
        { "action" => "add_to_memory", "reasons" => "test reason 1", "key" => "new_key", "value" => "new_value" },
        { "action" => "extract_insights", "reasons" => "test reason 2" }
      ]
    end

    before do
      allow(json_api_client).to receive(:query).and_return(llm_response)
    end

    it "returns an array of Action objects" do
      actions = action_determiner.get_next_action(article, memory)
      expect(actions).to be_an(Array)
      expect(actions.first).to be_an(ResearchAssistant::MemoryAgent::Action)
      expect(actions.last).to be_an(ResearchAssistant::MemoryAgent::Action)
    end

    it "correctly parses action data including key and value for memory actions" do
      actions = action_determiner.get_next_action(article, memory)
      expect(actions.first.name).to eq("add_to_memory")
      expect(actions.first.key).to eq("new_key")
      expect(actions.first.value).to eq("new_value")
      expect(actions.last.name).to eq("extract_insights")
      expect(actions.last.key).to be_nil
      expect(actions.last.value).to be_nil
    end

    it "adds action names to action_history" do
      action_determiner.get_next_action(article, memory)
      expect(action_determiner.action_history).to include("add_to_memory", "extract_insights")
    end
  end
end
