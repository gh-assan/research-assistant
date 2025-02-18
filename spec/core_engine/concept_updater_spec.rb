require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::ConceptUpdater do
  let(:mock_concept_extractor) { instance_double('ResearchAssistant::CoreEngine::ConceptExtractor') }
  let(:updater) { described_class.new(mock_concept_extractor) }

  describe '#update' do
    it 'updates the analysis with new concepts extracted from the response' do
      response = "This is a sample response with Concepts."
      topic = "This is a sample topic."
      analysis = { core_concepts: ['ExistingConcept'] }
      new_concepts = [
        { concept: 'Sample', relevance: 0.9 },
        { concept: 'Response', relevance: 0.8 },
        { concept: 'Concepts', relevance: 0.85 }
      ]

      expect(mock_concept_extractor).to receive(:extract).with(topic, response).and_return(new_concepts)

      result = updater.update(analysis, topic, response)

      expect(result[:core_concepts]).to include('ExistingConcept', 'Sample', 'Response', 'Concepts')
    end
  end
end