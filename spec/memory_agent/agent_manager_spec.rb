require 'spec_helper'

RSpec.describe ResearchAssistant::MemoryAgent::AgentManager do
  let(:json_api_client) { instance_double(ResearchAssistant::OllamaInterface::JsonApiClient) }
  let(:writer_api_client) { instance_double(ResearchAssistant::OllamaInterface::WriterApiClient) }
  let(:agent_action_executor) { instance_double(ResearchAssistant::MemoryAgent::AgentActionExecutor) }
  let(:agent_manager) do
    described_class.new(
      json_api_client,
      writer_api_client,
      file_manager,
      agent_action_executor
    )
  end

  let(:file_manager) { instance_double(ResearchAssistant::MemoryAgent::FileManager) }
  let(:memory_manager) { instance_double(ResearchAssistant::MemoryAgent::MemoryManager) }
  let(:knowledge_graph) { instance_double(ResearchAssistant::KnowledgeBase::KnowledgeGraph) }

  before do
    allow(agent_manager.termination_evaluator).to receive(:should_terminate?).and_return(false, true)
    allow(file_manager).to receive(:memory_manager).and_return(memory_manager)
    allow(file_manager).to receive(:save_iteration)
    allow(memory_manager).to receive(:read).and_return(knowledge_graph)
    allow(knowledge_graph).to receive(:graph).and_return(instance_double(RGL::AdjacencyGraph, vertices: ["concept1", "concept2"]))
    allow(knowledge_graph).to receive(:to_json).and_return("{}")
  end

  describe "#run" do
    it "loads memory, gets the next action, executes it, and enhances the article" do
      action1 = ResearchAssistant::MemoryAgent::Action.new(name: "test_action_1", reasons: "test_reasons_1")
      action2 = ResearchAssistant::MemoryAgent::Action.new(name: "test_action_2", reasons: "test_reasons_2")
      actions = [action1, action2]

      allow(agent_manager.action_determiner).to receive(:get_next_action).and_return(actions)
      allow(agent_action_executor).to receive(:run).with(action1, "topic", "").and_return("analysis_1")
      allow(agent_action_executor).to receive(:run).with(action2, "topic", "").and_return("analysis_2")
      allow(agent_manager.article_enhancer).to receive(:enhance).and_return("enhanced_article")
      allow(agent_manager.article_enhancer.write_api_client).to receive(:write_article).and_return("enhanced_article")

      expect(memory_manager).to receive(:read)
      expect(agent_manager.action_determiner).to receive(:get_next_action).with("", knowledge_graph)
      expect(agent_action_executor).to receive(:run).with(action1, "topic", "")
      expect(agent_action_executor).to receive(:run).with(action2, "topic", "")
      expect(file_manager).to receive(:save_iteration).with("enhanced_article", 1, [action1, action2], ["analysis_1", "analysis_2"])

      agent_manager.run("topic", "")
    end
  end
end
