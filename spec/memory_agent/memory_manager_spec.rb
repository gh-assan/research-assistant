require 'spec_helper'
require 'research_assistant/memory_agent/memory_manager'
require 'research_assistant/knowledge_base/knowledge_graph'

RSpec.describe ResearchAssistant::MemoryAgent::MemoryManager do
  let(:research_id) { "test_id" }
  let(:memory_manager) { described_class.new(research_id) }
  let(:memory_file) { File.join(ResearchAssistant.config.research_dir, research_id, 'knowledge_graph.json') }

  before do
    FileUtils.mkdir_p(File.dirname(memory_file))
  end

  after do
    FileUtils.rm_f(memory_file)
  end

  describe "#initialize" do
    it "creates a knowledge_graph.json file with an empty graph" do
      memory_manager
      expect(File.exist?(memory_file)).to be true
      kg = ResearchAssistant::KnowledgeBase::KnowledgeGraph.from_json(File.read(memory_file))
      expect(kg.graph.vertices).to be_empty
    end
  end

  describe "#read" do
    it "returns the knowledge graph" do
      expect(memory_manager.read).to be_a(ResearchAssistant::KnowledgeBase::KnowledgeGraph)
    end
  end

  describe "#write" do
    it "writes the knowledge graph to a file" do
      kg = memory_manager.read
      kg.add_concept("Ruby")
      memory_manager.write(kg)

      new_kg = ResearchAssistant::KnowledgeBase::KnowledgeGraph.from_json(File.read(memory_file))
      expect(new_kg.graph.has_vertex?("Ruby")).to be true
    end
  end

  describe "#retrieve_contextual_memories" do
    it "delegates to ContextualRetriever#retrieve_contextual_memories" do
      kg = memory_manager.read
      kg.add_concept("Ruby")
      memory_manager.write(kg)

      retrieved_memories = [{ key: "memory1", value: "Ruby" }]

      expect(memory_manager.instance_variable_get(:@contextual_retriever)).to receive(:retrieve_contextual_memories).with(["Ruby"], "context", 5).and_return(retrieved_memories)

      expect(memory_manager.retrieve_contextual_memories("context")).to eq(retrieved_memories)
    end
  end
end
