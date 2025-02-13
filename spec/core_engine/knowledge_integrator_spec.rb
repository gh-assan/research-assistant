require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::KnowledgeIntegrator do
  let(:mock_analyzer) { instance_double('ResponseAnalyzer') }
  let(:mock_updater) { instance_double('ConceptUpdater') }
  let(:mock_detector) { instance_double('GapDetector') }
  let(:integrator) { described_class.new(response_analyzer: mock_analyzer, concept_updater: mock_updater, gap_detector: mock_detector) }

  describe '#integrate' do
    it 'processes all responses' do
      analysis = { insights: [], core_concepts: [], knowledge_gaps: [] }
      responses = ["Response 1", "Response 2"]

      expect(mock_analyzer).to receive(:analyze).twice.and_return(analysis)
      expect(mock_updater).to receive(:update).twice.and_return(analysis)
      expect(mock_detector).to receive(:detect).twice.and_return(analysis)

      integrator.integrate(analysis, responses)
    end
  end
end