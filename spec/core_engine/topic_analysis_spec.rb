require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::ConceptExtractor do
  let(:extractor) { described_class.new }

  describe '#extract' do
    it 'returns a valid analysis hash' do
      topic = "Quantum Machine Learning"
      analysis = extractor.extract(topic)

      expect(analysis).to include(
                            core_concepts: an_instance_of(Array),
                            relationships: an_instance_of(Array)
                          )
    end
  end
end