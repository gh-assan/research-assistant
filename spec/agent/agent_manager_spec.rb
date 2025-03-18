require 'spec_helper'

RSpec.describe ResearchAssistant::Agent::AgentManager do
  let(:json_api_client) { instance_double(ResearchAssistant::OllamaInterface::JsonApiClient) }
  let(:writer_api_client) { instance_double(ResearchAssistant::OllamaInterface::WriterApiClient) }
  let(:file_manager) { instance_double(ResearchAssistant::Agent::FileManager) }
  let(:termination_evaluator) { instance_double(ResearchAssistant::Agent::TerminationEvaluator) }
  let(:article_enhancer) { instance_double(ResearchAssistant::Agent::ArticleEnhancer) }
  let(:action_determiner) { instance_double(ResearchAssistant::Agent::ActionDeterminer) }
  let(:agent_action_executor) { instance_double(ResearchAssistant::Agent::AgentActionExecutor) }
  let(:research_id) { 'sample_research_id' }
  let(:agent_manager) do
    described_class.new(json_api_client, writer_api_client, research_id, agent_action_executor).tap do |manager|
      manager.instance_variable_set(:@file_manager, file_manager)
      manager.instance_variable_set(:@termination_evaluator, termination_evaluator)
      manager.instance_variable_set(:@article_enhancer, article_enhancer)
      manager.instance_variable_set(:@action_determiner, action_determiner)
    end
  end
  let(:topic) { 'Sample Topic' }
  let(:generated_article) { 'This is the initial generated article.' }
  let(:action) { instance_double('Action', name: 'extract_insights') }
  let(:analysis) { 'Analysis result' }
  let(:enhanced_article) { 'This is the enhanced article.' }

  before do
    allow(termination_evaluator).to receive(:should_terminate?).and_return(false, true)
    allow(action_determiner).to receive(:get_next_action).and_return(action)
    allow(agent_action_executor).to receive(:run).and_return(analysis)
    allow(article_enhancer).to receive(:enhance).and_return(enhanced_article)
    allow(file_manager).to receive(:save_iteration)
  end

  describe '#run' do
    it 'executes iterations until the termination condition is met' do
      final_article = agent_manager.run(topic, generated_article)

      expect(final_article).to eq(enhanced_article)
      expect(termination_evaluator).to have_received(:should_terminate?).twice
      expect(action_determiner).to have_received(:get_next_action).once
      expect(agent_action_executor).to have_received(:run).with(action, topic, generated_article).once
      expect(article_enhancer).to have_received(:enhance).with(generated_article, action, analysis).once
      expect(file_manager).to have_received(:save_iteration).with(enhanced_article, 1, action, analysis).once
    end
  end
end