require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::ResponseAnalyzer do
  let(:analyzer) { described_class.new }

  describe '#analyze' do
    it 'adds insights to analysis' do
      analysis = { insights: [] }
      response = "Quantum effects can improve ML performance"
      
      result = analyzer.analyze(response, analysis)
      expect(result[:insights]).to include(response)
    end
  end
end