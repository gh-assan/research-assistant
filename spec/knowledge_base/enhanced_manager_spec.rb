# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ResearchAssistant::KnowledgeBase::EnhancedManager do
  let(:manager) { described_class.new('test_research') }

  describe '#save_artifact' do
    it 'saves a concept artifact' do
      concept = build(:concept)
      expect { manager.save_artifact(type: :concept, content: concept) }
        .to change { Dir.glob('research/test_research/concepts/*.json').size }.by(1)
    end
  end
end