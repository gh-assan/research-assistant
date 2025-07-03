require 'spec_helper'

RSpec.describe ResearchAssistant::MemoryAgent::AgentManager, "single action test" do
  let(:json_api_client) { instance_double(ResearchAssistant::OllamaInterface::JsonApiClient) }
  let(:writer_api_client) { instance_double(ResearchAssistant::OllamaInterface::WriterApiClient) }
  let(:agent_action_executor) { instance_double(ResearchAssistant::MemoryAgent::AgentActionExecutor) }

  let(:file_manager) { instance_double(ResearchAssistant::MemoryAgent::FileManager) }
  let(:memory_manager) { instance_double(ResearchAssistant::MemoryAgent::MemoryManager) }

  let(:agent_manager) do
    described_class.new(
      json_api_client,
      writer_api_client,
      file_manager,
      agent_action_executor
    )
  end

  before do
    allow(agent_manager.termination_evaluator).to receive(:should_terminate?).and_return(false, true)
    allow(file_manager).to receive(:memory_manager).and_return(memory_manager)
    allow(memory_manager).to receive(:read).and_return({ "memory_key" => "memory_value" })
    allow(file_manager).to receive(:save_iteration)
  end

  describe "#run" do
    it "calls memory_manager.write when add_to_memory action is executed" do
      action_log_action = ResearchAssistant::MemoryAgent::Action.new(name: "add_to_memory", reasons: "logging", key: "action_log_iteration_1", value: "Executed a single action.")
      actions = [action_log_action]

      allow(agent_manager.action_determiner).to receive(:get_next_action).and_return(actions)
      allow(agent_action_executor).to receive(:run).with(action_log_action, "topic", "").and_return(nil)

      expect(memory_manager).to receive(:read)
      expect(agent_manager.article_enhancer).to receive(:enhance).with("", [action_log_action], []).and_return("enhanced_article_after_log")
      expect(file_manager).to receive(:save_iteration).with("enhanced_article_after_log", 1, [action_log_action], [nil])

      agent_manager.run("topic", "")
    end
  end
end
