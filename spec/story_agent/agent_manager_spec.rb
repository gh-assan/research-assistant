require 'spec_helper'

RSpec.describe ResearchAssistant::StoryAgent::AgentManager do
  let(:json_api_client) { instance_double(ResearchAssistant::OllamaInterface::JsonApiClient) }
  let(:writer_api_client) { instance_double(ResearchAssistant::OllamaInterface::WriterApiClient) }
  let(:file_manager) { instance_double(ResearchAssistant::StoryAgent::FileManager) }
  let(:termination_evaluator) { instance_double(ResearchAssistant::StoryAgent::TerminationEvaluator) }
  let(:story_enhancer) { instance_double(ResearchAssistant::StoryAgent::StoryEnhancer) }
  let(:action_determiner) { instance_double(ResearchAssistant::StoryAgent::ActionDeterminer) }
  let(:agent_action_executor) { instance_double(ResearchAssistant::StoryAgent::AgentActionExecutor) }
  let(:story_id) { 'sample_story_id' }
  let(:agent_manager) do
    described_class.new(json_api_client, writer_api_client, story_id, agent_action_executor).tap do |manager|
      manager.instance_variable_set(:@file_manager, file_manager)
      manager.instance_variable_set(:@termination_evaluator, termination_evaluator)
      manager.instance_variable_set(:@story_enhancer, story_enhancer)
      manager.instance_variable_set(:@action_determiner, action_determiner)
    end
  end
  let(:topic) { 'Sample Topic' }
  let(:generated_story) { 'This is the initial generated story.' }
  let(:action) { instance_double('Action', name: 'enhance_story') }
  let(:enhanced_story) { 'This is the enhanced story.' }

  before do
    allow(termination_evaluator).to receive(:should_terminate?).and_return(false, true)
    allow(action_determiner).to receive(:get_next_action).and_return(action)
    allow(agent_action_executor).to receive(:run).and_return(enhanced_story)
    allow(file_manager).to receive(:save_iteration)
  end

  describe '#run' do
    it 'executes iterations until the termination condition is met' do
      final_story = agent_manager.run(topic, generated_story)

      expect(final_story).to eq(enhanced_story)
      expect(termination_evaluator).to have_received(:should_terminate?).twice
      expect(action_determiner).to have_received(:get_next_action).once
      expect(agent_action_executor).to have_received(:run).with(action, topic, generated_story).once
      expect(file_manager).to have_received(:save_iteration).with(enhanced_story, 1, action).once
    end
  end
end