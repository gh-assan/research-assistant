require 'spec_helper'
# require 'research_assistant/core_engine/depth_adjuster'

RSpec.describe ResearchAssistant::CoreEngine::DepthAdjuster do
  let(:adjuster) { described_class.new }

  describe '#adjust_depth' do
    it 'increases depth up to maximum level' do
      analysis = { iterations: [] }
      expect(adjuster.adjust_depth(analysis, 3)).to eq(3)
      expect(adjuster.adjust_depth(analysis, 10)).to eq(5)
    end
  end
end