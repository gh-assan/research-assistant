require 'spec_helper'

RSpec.describe ResearchAssistant::MemoryAgent::MemoryOptimizer do
  let(:optimizer) { described_class.new }
  let(:current_time) { Time.now.to_i }

  describe "#consolidate_and_forget_memories" do
    it "removes memories older than the forgetting threshold" do
      old_memory_time = current_time - (31 * 24 * 60 * 60) # 31 days ago
      recent_memory_time = current_time - (5 * 24 * 60 * 60) # 5 days ago

      initial_memories = {
        "old_memory" => { 'value' => "This is an old memory", 'last_accessed' => old_memory_time },
        "recent_memory" => { 'value' => "This is a recent memory", 'last_accessed' => recent_memory_time }
      }

      updated_memories = optimizer.consolidate_and_forget_memories(initial_memories, 30)

      expect(updated_memories).to have_key("recent_memory")
      expect(updated_memories).not_to have_key("old_memory")
    end

    it "retains memories within the forgetting threshold" do
      recent_memory_time = current_time - (10 * 24 * 60 * 60) # 10 days ago
      initial_memories = {
        "recent_memory" => { 'value' => "This is a recent memory", 'last_accessed' => recent_memory_time }
      }

      updated_memories = optimizer.consolidate_and_forget_memories(initial_memories, 30)

      expect(updated_memories).to have_key("recent_memory")
    end

    it "converts simple strings to hashes with last_accessed and value keys" do
      initial_memories = {
        "simple_string" => "just a string"
      }

      updated_memories = optimizer.consolidate_and_forget_memories(initial_memories, 30)

      expect(updated_memories["simple_string"]).to be_a(Hash)
      expect(updated_memories["simple_string"]['value']).to eq("just a string")
      expect(updated_memories["simple_string"]['last_accessed']).to be_within(2).of(current_time)
    end

    it "handles memories without last_accessed by converting them" do
      initial_memories = {
        "legacy_memory" => "This is a legacy memory without timestamp"
      }

      updated_memories = optimizer.consolidate_and_forget_memories(initial_memories, 30)

      expect(updated_memories).to have_key("legacy_memory")
      expect(updated_memories["legacy_memory"]).to be_a(Hash)
      expect(updated_memories["legacy_memory"]['value']).to eq("This is a legacy memory without timestamp")
      expect(updated_memories["legacy_memory"]['last_accessed']).to be_within(2).of(current_time)
    end
  end
end
