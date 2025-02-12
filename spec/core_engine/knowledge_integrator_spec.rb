require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::KnowledgeIntegrator do
  let(:integrator) { described_class.new }
  let(:mock_analyzer) { instance_double('ResponseAnalyzer') }
  let(:mock_updater) { instance_double('ConceptUpdater') }
  let(:mock_detector) { instance_double('GapDetector') }

  before do
    allow(ResponseAnalyzer).to receive(:new).and_return(mock_analyzer)
    allow(ConceptUpdater).to receive(:new).and_return(mock_updater)
    allow(GapDetector).to receive(:new).and_return(mock_detector)
  end

  describe '#integrate' do
    it 'processes all responses' do
      analysis = { insights: [], core_concepts: [], knowledge_gaps: [] }
      responses = ["Response 1", "Response 2"]

      expect(mock_analyzer).to receive(:analyze).twice
      expect(mock_updater).to receive(:update).twice
      expect(mock_detector).to receive(:detect).twice

      integrator.integrate(analysis, responses)
    end
  end
end