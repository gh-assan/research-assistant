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
    it "returns the content of the memory file" do
      File.write(memory_file, JSON.pretty_generate({ "key" => "value" }))
      expect(memory_manager.read).to eq({ "key" => "value" })
    end
  end

  describe "#write" do
    it "writes the given data to the memory file" do
      memory_manager.write({ "new_key" => "new_value" })
      expect(JSON.parse(File.read(memory_file))).to eq({ "new_key" => "new_value" })
    end
  end

  describe "#retrieve_contextual_memories" do
    before do
      memory_manager.write({
        "memory1" => "This is about Ruby programming.",
        "memory2" => "Learning about Python data structures.",
        "memory3" => "Ruby on Rails development is fun.",
        "memory4" => "A completely unrelated memory."
      })
    end

    it "returns relevant memories based on context keywords" do
      context = "I'm working on a Ruby project."
      retrieved = memory_manager.retrieve_contextual_memories(context)
      expect(retrieved.count).to eq(2)
      expect(retrieved.map { |m| m[:key] }).to include("memory1", "memory3")
    end

    it "returns memories sorted by relevance (simple keyword count)" do
      context = "Ruby programming and development."
      retrieved = memory_manager.retrieve_contextual_memories(context)
      expect(retrieved.first[:key]).to eq("memory1") # "Ruby programming" has both keywords
    end

    it "limits the number of returned memories" do
      context = "programming"
      retrieved = memory_manager.retrieve_contextual_memories(context, 1)
      expect(retrieved.count).to eq(1)
    end

    it "returns an empty array if no relevant memories are found" do
      context = "nonexistent topic"
      retrieved = memory_manager.retrieve_contextual_memories(context)
      expect(retrieved).to be_empty
    end
  end

  describe "#extract_keywords_from_context" do
    it "extracts unique lowercase words from the context" do
      context = "Hello World, hello again!"
      keywords = memory_manager.send(:extract_keywords_from_context, context)
      expect(keywords).to match_array(["hello", "world", "again"])
    end

    it "handles empty context" do
      context = ""
      keywords = memory_manager.send(:extract_keywords_from_context, context)
      expect(keywords).to be_empty
    end

    it "handles context with special characters" do
      context = "@#$!%^&*()_+-=[]{}|;:'',./<>?`~"
      keywords = memory_manager.send(:extract_keywords_from_context, context)
      expect(keywords).to be_empty
    end
  end
end
