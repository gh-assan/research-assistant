require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::TerminationEvaluator do
  let(:evaluator) { described_class.new }

  describe '#should_terminate?' do
    context 'when saturation detected' do
      it 'returns true' do
        analysis = { insights: Array.new(10, "Same insight") }
        expect(evaluator.should_terminate?(analysis)).to be true
      end
    end

    context 'when objectives met' do
      it 'returns true' do
        analysis = { knowledge_gaps: [] }
        expect(evaluator.should_terminate?(analysis)).to be true
      end
    end

    context 'when redundancy detected' do
      it 'returns true' do
        analysis = { iterations: Array.new(10, "Same iteration") }
        expect(evaluator.should_terminate?(analysis)).to be true
      end
    end
  end
end