require 'spec_helper'

RSpec.describe ResearchAssistant::MemoryAgent::ContextualRetriever do
  let(:retriever) { described_class.new }

  describe "#retrieve_contextual_memories" do
    let(:all_memories) do
      {
        "memory1" => { 'value' => "This is about Ruby programming.", 'last_accessed' => Time.now.to_i },
        "memory2" => { 'value' => "Learning about Python data structures.", 'last_accessed' => Time.now.to_i },
        "memory3" => { 'value' => "Ruby on Rails development is fun.", 'last_accessed' => Time.now.to_i },
        "memory4" => { 'value' => "A completely unrelated memory.", 'last_accessed' => Time.now.to_i },
        "memory5" => "Simple string memory about Ruby."
      }
    end

    it "returns relevant memories based on context keywords" do
      context = "I'm working on a Ruby project."
      retrieved = retriever.retrieve_contextual_memories(all_memories, context)
      expect(retrieved.count).to eq(3)
      expect(retrieved.map { |m| m[:key] }).to include("memory1", "memory3", "memory5")
    end

    it "returns memories sorted by relevance (simple keyword count)" do
      context = "Ruby programming and development."
      retrieved = retriever.retrieve_contextual_memories(all_memories, context)
      # Expect memory1 to be first as it contains both "Ruby" and "programming"
      expect(retrieved.first[:key]).to eq("memory1")
    end

    it "limits the number of returned memories" do
      context = "programming"
      retrieved = retriever.retrieve_contextual_memories(all_memories, context, 1)
      expect(retrieved.count).to eq(1)
    end

    it "returns an empty array if no relevant memories are found" do
      context = "nonexistent topic"
      retrieved = retriever.retrieve_contextual_memories(all_memories, context)
      expect(retrieved).to be_empty
    end

    it "handles memories that are not hashes" do
      context = "Ruby"
      retrieved = retriever.retrieve_contextual_memories(all_memories, context)
      expect(retrieved.map { |m| m[:key] }).to include("memory5")
    end
  end

  describe "#extract_keywords_from_context" do
    it "extracts unique lowercase words from the context" do
      context = "Hello World, hello again!"
      keywords = retriever.send(:extract_keywords_from_context, context)
      expect(keywords).to match_array(["hello", "world", "again"])
    end

    it "handles empty context" do
      context = ""
      keywords = retriever.send(:extract_keywords_from_context, context)
      expect(keywords).to be_empty
    end

    it "handles context with special characters" do
      context = "@#$!%^&*()_+-=[]{}|;:\'\',./<>?`~"
      keywords = retriever.send(:extract_keywords_from_context, context)
      expect(keywords).to be_empty
    end
  end
end
