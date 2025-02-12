require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::FeedbackSystem do
  let(:feedback) { described_class.new }

  describe '#update' do
    it 'tracks performance metrics' do
      analysis = { questions: Array.new(3), insights: Array.new(5) }
      feedback.update(analysis, 2)
      
      expect(feedback.instance_variable_get(:@performance_metrics)).to include(
        iterations: 2,
        questions_generated: 3,
        insights_found: 5
      )
    end
  end

  describe '#adaptive_learning' do
    it 'adjusts parameters based on insights' do
      feedback.instance_variable_set(:@performance_metrics, { insights_found: 3 })
      expect(feedback.adaptive_learning).to include(depth_adjustment: 1)
      
      feedback.instance_variable_set(:@performance_metrics, { insights_found: 6 })
      expect(feedback.adaptive_learning).to include(depth_adjustment: -1)
    end
  end
end