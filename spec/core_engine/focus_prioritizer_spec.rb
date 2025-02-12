require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::FocusPrioritizer do
  let(:prioritizer) { described_class.new }

  describe '#prioritize' do
    it 'orders knowledge gaps by priority' do
      analysis = {
        knowledge_gaps: [
          { area: "Low Priority", priority: 1 },
          { area: "High Priority", priority: 3 }
        ]
      }
      expect(prioritizer.prioritize(analysis)).to eq(["High Priority", "Low Priority"])
    end

    it 'returns empty array when no gaps exist' do
      analysis = { knowledge_gaps: [] }
      expect(prioritizer.prioritize(analysis)).to be_empty
    end
  end
end