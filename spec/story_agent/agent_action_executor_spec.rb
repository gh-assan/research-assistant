require 'spec_helper'

RSpec.describe ResearchAssistant::StoryAgent::AgentActionExecutor do
  let(:generic_command) { instance_double(ResearchAssistant::StoryAgent::GenericCommand) }
  let(:executor) { described_class.new(generic_command: generic_command) }
  let(:topic) { "Sample Topic" }
  let(:story) { "This is a sample story content." }

  describe '#run' do
    context 'when the action is "extract_insights"' do
      let(:action) { instance_double("Action", name: "extract_insights") }

      it 'returns a predefined message for extracting insights' do
        result = executor.run(action, topic, story)

        expect(result).to eq("Insights extracted")
      end
    end

    context 'when the action is unknown' do
      let(:action) { instance_double("Action", name: "unknown_action") }

      it 'calls the generic_command with the topic, story, and action' do
        allow(generic_command).to receive(:execute).with(topic, story, action).and_return("Generic command executed")

        result = executor.run(action, topic, story)

        expect(result).to eq("Generic command executed")
        expect(generic_command).to have_received(:execute).with(topic, story, action)
      end
    end
  end
end