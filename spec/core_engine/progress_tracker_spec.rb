require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::ProgressTracker do
  let(:tracker) { described_class.new }

  describe '#next_iteration' do
    it 'increments the iteration count' do
      expect { tracker.next_iteration }.to change { tracker.current_iteration }.from(0).to(1)
    end
  end

  describe '#current_iteration' do
    it 'returns the current iteration number' do
      expect(tracker.current_iteration).to eq(0)
      3.times { tracker.next_iteration }
      expect(tracker.current_iteration).to eq(3)
    end
  end
end