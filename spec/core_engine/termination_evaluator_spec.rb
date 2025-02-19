require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::TerminationEvaluator do
  let(:api_client) { instance_double(ResearchAssistant::OllamaInterface::ApiClient) }
  let(:json_api_client) { instance_double(ResearchAssistant::OllamaInterface::JsonApiClient) }
  let(:evaluator) { described_class.new(api_client, json_api_client) }
  let(:knowledge) {
    instance_double('ResearchAssistant::KnowledgeBase::Knowledge',
                    knowledge_gaps: [],
                    user_intent: 'Write a detailed article about climate change.',
                    article: 'This is the article content.',
                    iteration: 2)
  }
  let(:score_response) { { 'rank' => 95 } }

  describe '#should_terminate?' do
    context 'when objectives are met' do
      it 'returns true' do
        allow(knowledge).to receive(:knowledge_gaps).and_return([])
        expect(evaluator.should_terminate?(knowledge)).to be true
      end
    end

    context 'when minimum score is met' do
      it 'returns true' do
        allow(api_client).to receive(:query).and_return(score_response.to_json)
        allow(json_api_client).to receive(:query).with(score_response.to_json, ResearchAssistant::CoreEngine::Models::RANK_SCHEMA).and_return(score_response)

        expect(evaluator.should_terminate?(knowledge)).to be true
      end
    end

    context 'when maximum iterations are reached' do
      it 'returns true' do
        allow(knowledge).to receive(:iteration).and_return(2)
        expect(evaluator.should_terminate?(knowledge)).to be true
      end
    end

    context 'when objectives are not met and minimum score is not met' do
      it 'returns false' do
        allow(knowledge).to receive(:iteration).and_return(1)
        allow(knowledge).to receive(:knowledge_gaps).and_return(['Gap 1'])
        allow(api_client).to receive(:query).and_return(score_response.to_json)
        allow(json_api_client).to receive(:query).with(score_response.to_json, ResearchAssistant::CoreEngine::Models::RANK_SCHEMA).and_return({ 'rank' => 85 })

        expect(evaluator.should_terminate?(knowledge)).to be false
      end
    end
  end
end