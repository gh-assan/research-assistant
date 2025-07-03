require 'spec_helper'

RSpec.describe ResearchAssistant::MemoryAgent::MemoryManager do
  let(:research_id) { "test_id" }
  let(:memory_manager) { described_class.new(research_id) }
  let(:memory_file) { File.join(ResearchAssistant.config.research_dir, research_id, 'memory.json') }

  before do
    FileUtils.mkdir_p(File.dirname(memory_file))
  end

  after do
    FileUtils.rm_f(memory_file)
  end

  describe "#initialize" do
    it "creates a memory.json file with an empty hash" do
      memory_manager
      expect(File.exist?(memory_file)).to be true
      expect(JSON.parse(File.read(memory_file))).to eq({})
    end
  end

  describe "#read" do
    it "delegates to MemoryStore#read" do
      expect(memory_manager.instance_variable_get(:@memory_store)).to receive(:read).and_return({ "key" => "value" })
      expect(memory_manager.read).to eq({ "key" => "value" })
    end
  end

  describe "#write" do
    it "delegates to MemoryStore#write and adds last_accessed timestamp" do
      data = { "new_key" => "new_value" }
      expect(memory_manager.instance_variable_get(:@memory_store)).to receive(:write) do |arg|
        expect(arg["new_key"]).to be_a(Hash)
        expect(arg["new_key"]['value']).to eq("new_value")
        expect(arg["new_key"]['last_accessed']).to be_within(2).of(Time.now.to_i)
      end
      memory_manager.write(data)
    end
  end

  describe "#consolidate_and_forget_memories" do
    it "delegates to MemoryOptimizer#consolidate_and_forget_memories and writes the result" do
      all_memories = { "old_memory" => { 'value' => "old", 'last_accessed' => 1 } }
      updated_memories = { "recent_memory" => { 'value' => "recent", 'last_accessed' => 100 } }

      allow(memory_manager).to receive(:read).and_return(all_memories)
      expect(memory_manager.instance_variable_get(:@memory_optimizer)).to receive(:consolidate_and_forget_memories).with(all_memories, 30).and_return(updated_memories)
      expect(memory_manager).to receive(:write).with(updated_memories)

      memory_manager.consolidate_and_forget_memories(30)
    end
  end

  describe "#retrieve_contextual_memories" do
    it "delegates to ContextualRetriever#retrieve_contextual_memories" do
      all_memories = { "memory1" => "Ruby" }
      retrieved_memories = [{ key: "memory1", value: "Ruby" }]

      allow(memory_manager).to receive(:read).and_return(all_memories)
      expect(memory_manager.instance_variable_get(:@contextual_retriever)).to receive(:retrieve_contextual_memories).with(all_memories, "context", 5).and_return(retrieved_memories)

      expect(memory_manager.retrieve_contextual_memories("context")).to eq(retrieved_memories)
    end
  end
end
