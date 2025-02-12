# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ResearchAssistant::Output::Formatter do
  let(:knowledge_base) { instance_double('KnowledgeBase::EnhancedManager') }
  let(:formatter) { described_class.new('test_research', knowledge_base) }

  describe '#generate_article' do
    it 'generates a markdown article' do
      allow(knowledge_base).to receive(:load_concepts).and_return([build(:concept)])
      allow(knowledge_base).to receive(:load_iterations).and_return([build(:iteration)])
      allow(knowledge_base).to receive(:load_analysis).and_return({ topic: "Quantum Machine Learning" })

      article = formatter.generate_article(format: :markdown)
      expect(article).to include("# Advances in")
    end
  end
end