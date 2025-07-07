require 'spec_helper'
require 'research_assistant/knowledge_base/knowledge_graph'

RSpec.describe ResearchAssistant::KnowledgeBase::KnowledgeGraph do
  subject(:kg) { described_class.new }

  describe '#add_concept' do
    it 'adds a concept to the graph' do
      kg.add_concept('Ruby')
      expect(kg.graph.has_vertex?('Ruby')).to be true
    end

    it 'does not add a duplicate concept' do
      kg.add_concept('Ruby')
      kg.add_concept('Ruby')
      expect(kg.graph.vertices.count).to eq(1)
    end
  end

  describe '#add_relationship' do
    it 'adds a relationship between two concepts' do
      kg.add_relationship('Ruby', 'Rails', 'is used by')
      expect(kg.graph.has_edge?('Ruby', 'Rails')).to be true
    end

    it 'stores the label for the relationship' do
      kg.add_relationship('Ruby', 'Rails', 'is used by')
      expect(kg.get_relationship_label('Ruby', 'Rails')).to eq('is used by')
    end

    it 'automatically adds concepts when a relationship is added' do
      kg.add_relationship('Ruby', 'Rails', 'is used by')
      expect(kg.graph.has_vertex?('Ruby')).to be true
      expect(kg.graph.has_vertex?('Rails')).to be true
    end
  end

  describe '#find_related_concepts' do
    before do
      kg.add_relationship('Ruby', 'Rails', 'is used by')
      kg.add_relationship('Ruby', 'Sinatra', 'is used by')
    end

    it 'finds all concepts related to a given concept' do
      related = kg.find_related_concepts('Ruby')
      expect(related.map { |r| r[:concept] }).to contain_exactly('Rails', 'Sinatra')
    end

    it 'includes the relationship label in the result' do
      related = kg.find_related_concepts('Ruby').first
      expect(related[:concept]).to eq('Rails')
      expect(related[:relationship]).to eq('is used by')
    end

    it 'returns an empty array if the concept does not exist' do
      expect(kg.find_related_concepts('Python')).to be_empty
    end
  end

  describe 'JSON serialization' do
    before do
      kg.add_relationship('Ruby', 'Rails', 'is used by')
    end

    it 'serializes the graph to a JSON string' do
      json = kg.to_json
      data = JSON.parse(json)
      expect(data['concepts']).to contain_exactly('Ruby', 'Rails')
      expect(data['relationships'].first['source']).to eq('Ruby')
      expect(data['relationships'].first['target']).to eq('Rails')
      expect(data['relationships'].first['label']).to eq('is used by')
    end

    it 'deserializes a JSON string to a KnowledgeGraph object' do
      json = kg.to_json
      new_kg = described_class.from_json(json)
      expect(new_kg.graph.has_edge?('Ruby', 'Rails')).to be true
      expect(new_kg.get_relationship_label('Ruby', 'Rails')).to eq('is used by')
    end
  end
end
