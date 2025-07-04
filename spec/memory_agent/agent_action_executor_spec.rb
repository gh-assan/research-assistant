require 'spec_helper'

RSpec.describe ResearchAssistant::MemoryAgent::AgentActionExecutor do
  let(:memory_manager) { instance_double(ResearchAssistant::MemoryAgent::MemoryManager) }
  let(:knowledge_graph) { instance_double(ResearchAssistant::KnowledgeBase::KnowledgeGraph) }
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

  before do
    allow(memory_manager).to receive(:read).and_return(knowledge_graph)
    allow(memory_manager).to receive(:write)
  end

  describe "#run" do
    context "when the action is add_concept" do
      let(:action) { ResearchAssistant::MemoryAgent::Action.new(name: "add_concept", value: "new_concept") }

      it "adds a concept to the knowledge graph" do
        expect(knowledge_graph).to receive(:add_concept).with("new_concept")
        executor.run(action, "topic", "article")
      end
    end

    context "when the action is add_relationship" do
      let(:action) { ResearchAssistant::MemoryAgent::Action.new(name: "add_relationship", key: "source_concept", value: "target_concept", reasons: "relationship_label") }

      it "adds a relationship to the knowledge graph" do
        expect(knowledge_graph).to receive(:add_relationship).with("source_concept", "target_concept", "relationship_label")
        executor.run(action, "topic", "article")
      end
    end

    context "when the action is find_related_concepts" do
      let(:action) { ResearchAssistant::MemoryAgent::Action.new(name: "find_related_concepts", value: "concept_to_find") }

      it "finds related concepts from the knowledge graph" do
        expect(knowledge_graph).to receive(:find_related_concepts).with("concept_to_find").and_return(["related_concept"])
        expect(executor.run(action, "topic", "article")).to eq(["related_concept"])
      end
    end
  end
end
