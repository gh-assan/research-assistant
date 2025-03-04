# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::TerminationEvaluator do
  let(:reasoning_api_client) { instance_double(ResearchAssistant::OllamaInterface::ReasoningClient) }
  let(:json_api_client) { instance_double(ResearchAssistant::OllamaInterface::JsonApiClient) }
  let(:termination_evaluator) { described_class.new(reasoning_api_client, json_api_client) }
  let(:knowledge) do
    ResearchAssistant::KnowledgeBase::Knowledge.new(
      insights: [],
      concepts: [],
      relations: [],
      knowledge_gaps: [],
      questions: [],
      article: 'This is the article content.',
      user_intent: 'Understand the topic.',
      topic: 'Sample Topic',
      iteration: 1,
      max_iterations: 5
    )
  end

  describe '#should_terminate?' do
    context 'when max iterations are reached' do
      it 'returns true' do
        knowledge.iteration = 5

        expect(termination_evaluator.should_terminate?(knowledge)).to be true
      end
    end

    context 'when min score is met' do
      it 'returns true' do
        knowledge.iteration = 2
        allow(reasoning_api_client).to receive(:query).and_return('{"rank": 95}')
        allow(json_api_client).to receive(:query).and_return('rank' => 95)

        expect(termination_evaluator.should_terminate?(knowledge)).to be true
      end
    end

    context 'when none of the termination conditions are met' do
      it 'returns false' do
        knowledge.iteration = 1
        allow(reasoning_api_client).to receive(:query).and_return('{"rank": 85}')
        allow(json_api_client).to receive(:query).and_return('rank' => 85)

        expect(termination_evaluator.should_terminate?(knowledge)).to be false
      end
    end
  end

  describe '#max_iterations_reached?' do
    it 'returns true when max iterations are reached' do
      knowledge.iteration = 5
      expect(termination_evaluator.send(:max_iterations_reached?, knowledge)).to be true
    end

    it 'returns false when max iterations are not reached' do
      knowledge.iteration = 3
      expect(termination_evaluator.send(:max_iterations_reached?, knowledge)).to be false
    end
  end

  describe '#min_score_met?' do
    it 'returns true when the score is greater than or equal to 90 and iteration is greater than 1' do
      knowledge.iteration = 2
      allow(reasoning_api_client).to receive(:query).and_return('{"rank": 90}')
      allow(json_api_client).to receive(:query).and_return('rank' => 90)

      expect(termination_evaluator.send(:min_score_met?, knowledge)).to be true
    end

    it 'returns false when the score is less than 90' do
      knowledge.iteration = 2
      allow(reasoning_api_client).to receive(:query).and_return('{"rank": 85}')
      allow(json_api_client).to receive(:query).and_return('rank' => 85)

      expect(termination_evaluator.send(:min_score_met?, knowledge)).to be false
    end

    it 'returns false when iteration is less than or equal to 1' do
      knowledge.iteration = 1
      allow(reasoning_api_client).to receive(:query).and_return('{"rank": 95}')
      allow(json_api_client).to receive(:query).and_return('rank' => 95)

      expect(termination_evaluator.send(:min_score_met?, knowledge)).to be false
    end
  end

  describe '#objectives_met?' do
    it 'returns false when knowledge gaps are empty and iteration is greater than or equal to 2' do
      knowledge.knowledge_gaps = []
      knowledge.iteration = 2

      expect(termination_evaluator.send(:objectives_met?, knowledge)).to be false
    end
  end
end