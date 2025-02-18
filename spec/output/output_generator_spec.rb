# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ResearchAssistant::Output::OutputGenerator do
  let(:write_api_client) { instance_double('WriteApiClient') }
  let(:generator) { described_class.new(write_api_client) }
  let(:knowledge) {
    instance_double('ResearchAssistant::KnowledgeBase::Knowledge',
                    user_intent: 'Write a detailed article about climate change.',
                    topic: 'Climate Change',
                    insights: ['Insight 1', 'Insight 2'],
                    knowledge_gaps: ['Gap 1', 'Gap 2'],
                    concepts: ['Concept 1', 'Concept 2'],
                    relations: ['Relation 1', 'Relation 2'],
                    questions: ['Question 1', 'Question 2'])
  }
  let(:last_round_responses) { 'This is the last round response.' }
  let(:prompt) {
    "Write a detailed article about climate change.
                  On topic: Climate Change
                  check the extracted Insights: [\"Insight 1\", \"Insight 2\"]
                  and make sure to fill Knowledge Gaps: [\"Gap 1\", \"Gap 2\"]
                  with focus on Concepts: [\"Concept 1\", \"Concept 2\"]
                  and relations : [\"Relation 1\", \"Relation 2\"]
                  and you should answer the Questions: [\"Question 1\", \"Question 2\"]
                  where the last round Responses was: This is the last round response.
                  "
  }
  let(:api_response) { 'Generated article content.' }

  describe '#generate_article' do
    context 'when the API request is successful' do
      it 'returns the generated article' do
        allow(write_api_client).to receive(:write_article).with(prompt).and_return(api_response)

        article = generator.generate_article(knowledge, last_round_responses)
        expect(article).to eq(api_response)
      end
    end

    context 'when the API request fails' do
      it 'raises an API error' do
        allow(write_api_client).to receive(:write_article).with(prompt).and_raise(RuntimeError, 'API Error: Something went wrong')

        expect { generator.generate_article(knowledge, last_round_responses) }.to raise_error(RuntimeError, 'API Error: Something went wrong')
      end
    end

    context 'when there is a connection error' do
      it 'raises a connection error' do
        allow(write_api_client).to receive(:write_article).with(prompt).and_raise(RuntimeError, 'Connection Error: Connection failed')

        expect { generator.generate_article(knowledge, last_round_responses) }.to raise_error(RuntimeError, 'Connection Error: Connection failed')
      end
    end
  end
end