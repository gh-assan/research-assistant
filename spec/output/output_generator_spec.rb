# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ResearchAssistant::Output::OutputGenerator do
  let(:write_api_client) { instance_double(ResearchAssistant::OllamaInterface::WriterApiClient) }
  let(:output_generator) { described_class.new(write_api_client) }
  let(:knowledge) do
    ResearchAssistant::KnowledgeBase::Knowledge.new(
      insights: [
        { 'insight' => 'The sky is blue.', 'classification' => 'foundational', 'significance' => 'It describes the color of the sky.' }
      ],
      concepts: [
        { 'concept' => 'sky', 'relevance' => 'foundational' }
      ],
      knowledge_gaps: [
        { 'insight' => 'Missing foundational concept.', 'classification' => 'foundational', 'significance' => 'It is crucial for the analysis.' }
      ],
      questions: [
        { 'question' => 'What is the color of the sky?', 'type' => 'foundational', 'explanation' => 'It addresses the basic principle of the text.' }
      ],
      relations: [
        { 'insight' => 'The sky is blue.', 'classification' => 'associative', 'significance' => 'It describes the color of the sky.' }
      ],
      article: 'This is the article content.',
      last_round_article: 'This is the last round article content.',
      user_intent: 'To understand the color of the sky.',
      topic: 'The sky',
      iteration: 1
    )
  end

  describe '#generate_article' do
    context 'when the API request is successful' do
      it 'returns the generated article' do
        prompt = output_generator.send(:build_prompt, knowledge)
        expected_article = 'Generated article content.'

        allow(write_api_client).to receive(:write_article).with(prompt).and_return(expected_article)

        article = output_generator.generate_article(knowledge)
        expect(article).to eq(expected_article)
      end
    end

    context 'when the API request fails' do
      it 'raises an error' do
        prompt = output_generator.send(:build_prompt, knowledge)

        allow(write_api_client).to receive(:write_article).with(prompt).and_raise(StandardError, 'API Error')

        expect { output_generator.generate_article(knowledge) }.to raise_error(StandardError, 'Failed to generate article: API Error')
      end
    end
  end
end