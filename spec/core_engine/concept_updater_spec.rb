require 'spec_helper'
# require_relative '../../lib/research_assistant/core_engine/concept_updater'

RSpec.describe ResearchAssistant::CoreEngine::ConceptUpdater do
  let(:updater) { described_class.new }

  describe '#update' do
    it 'adds new concepts without duplicates' do
      analysis = { core_concepts: ["AI"] }
      response = "Quantum Machine Learning (QML) combines AI and Quantum Computing"
      
      result = updater.update(analysis, response)
      expect(result[:core_concepts]).to match_array(["AI", "Quantum", "Machine", "Learning", "QML", "Computing"])
    end
  end
end