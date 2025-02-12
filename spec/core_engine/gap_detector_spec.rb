require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::GapDetector do
  let(:detector) { described_class.new }

  describe '#detect' do
    it 'identifies new knowledge gaps' do
      analysis = { knowledge_gaps: [] }
      response = "The relationship between quantum entanglement and neural networks remains unclear"
      
      result = detector.detect(analysis, response)
      expect(result[:knowledge_gaps].size).to eq(1)
    end
  end
end