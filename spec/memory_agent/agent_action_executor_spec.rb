require 'spec_helper'

RSpec.describe ResearchAssistant::MemoryAgent::AgentActionExecutor do
  let(:memory_manager) { instance_double(ResearchAssistant::MemoryAgent::MemoryManager) }
  let(:executor) do
    described_class.new(
      insights_extractor: nil,
      concept_extractor: nil,
      gap_detector: nil,
      questions_engine: nil,
      relations_finder: nil,
      generic_command: nil,
      memory_manager: memory_manager
    )
  end

  describe "#run" do
    context "when the action is add_to_memory" do
      let(:action) { ResearchAssistant::MemoryAgent::Action.new(name: "add_to_memory", key: "test_key", value: "test_value") }

      it "adds the key-value pair to the memory" do
        expect(memory_manager).to receive(:read).and_return({})
        expect(memory_manager).to receive(:write).with({ "test_key" => "test_value" })
        executor.run(action, "topic", "article")
      end
    end

    context "when the action is update_memory" do
      let(:action) { ResearchAssistant::MemoryAgent::Action.new(name: "update_memory", key: "test_key", value: "new_value") }

      it "updates the value of the key in the memory" do
        expect(memory_manager).to receive(:read).and_return({ "test_key" => "old_value" })
        expect(memory_manager).to receive(:write).with({ "test_key" => "new_value" })
        executor.run(action, "topic", "article")
      end
    end

    context "when the action is read_memory" do
      let(:action) { ResearchAssistant::MemoryAgent::Action.new(name: "read_memory", key: "test_key") }

      it "reads the value of the key from the memory" do
        expect(memory_manager).to receive(:read).and_return({ "test_key" => "test_value" })
        expect(executor.run(action, "topic", "article")).to eq("test_value")
      end
    end
  end
end
