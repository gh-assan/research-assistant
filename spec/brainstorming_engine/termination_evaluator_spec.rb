require 'spec_helper'

RSpec.describe ResearchAssistant::BrainstormingEngine::TerminationEvaluator do
  let(:termination_evaluator) { described_class.new }
  let(:max_iterations) { 5 }

  before do
    allow(ResearchAssistant.config).to receive(:max_iterations).and_return(max_iterations)
  end

  describe '#should_terminate?' do
    context 'when the iteration number is less than the max iterations' do
      it 'returns false' do
        expect(termination_evaluator.should_terminate?(4)).to be false
      end
    end

    context 'when the iteration number is equal to the max iterations' do
      it 'returns true' do
        expect(termination_evaluator.should_terminate?(5)).to be true
      end
    end

    context 'when the iteration number is greater than the max iterations' do
      it 'returns true' do
        expect(termination_evaluator.should_terminate?(6)).to be true
      end
    end
  end

  describe '#max_iterations_reached?' do
    context 'when the iteration number is less than the max iterations' do
      it 'returns false' do
        expect(termination_evaluator.send(:max_iterations_reached?, 4)).to be false
      end
    end

    context 'when the iteration number is equal to the max iterations' do
      it 'returns true' do
        expect(termination_evaluator.send(:max_iterations_reached?, 5)).to be true
      end
    end

    context 'when the iteration number is greater than the max iterations' do
      it 'returns true' do
        expect(termination_evaluator.send(:max_iterations_reached?, 6)).to be true
      end
    end
  end
end