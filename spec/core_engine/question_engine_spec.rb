# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::QuestionEngine do
  let(:api_client) { instance_double(ResearchAssistant::OllamaInterface::ApiClient) }
  let(:engine) { described_class.new }
  let(:topic) { 'This is a sample topic.' }
  let(:article) { 'The sky is blue and the sun is bright.' }
  let(:prompt) do
    <<~PROMPT
      Topic: #{topic}
      Article: #{article}
    PROMPT
  end
  let(:api_response) {
    {
      'questions' => [
        { 'type' => 'foundational', 'question' => 'What is the color of the sky?', 'priority' => 'high', 'relevance' => 'foundational', 'explanation' => 'It addresses the basic principle of the text.' },
        { 'type' => 'critical', 'question' => 'Why is the sun bright?', 'priority' => 'medium', 'relevance' => 'critical', 'explanation' => 'It examines the strength of the idea presented.' }
      ]
    }
  }
  let(:response) { api_response.to_json }

  before do
    allow(ResearchAssistant::OllamaInterface::ApiClient).to receive(:new).with('research-assistant-question-engine-model').and_return(api_client)
    allow(api_client).to receive(:query).with(prompt).and_return(response)
  end

  describe '#extract' do
    context 'when the API request is successful' do
      it 'returns the generated questions' do
        questions = engine.extract(topic, article)
        expect(questions).not_to be_empty
        expect(questions).to include('questions')
      end
    end

    context 'when the API request fails' do
      it 'raises an API error' do
        allow(api_client).to receive(:query).with(prompt).and_raise(RuntimeError, 'API Error: Something went wrong')

        expect { engine.extract(topic, article) }.to raise_error(RuntimeError, 'API Error: Something went wrong')
      end
    end

    context 'when there is a connection error' do
      it 'raises a connection error' do
        allow(api_client).to receive(:query).with(prompt).and_raise(RuntimeError, 'Connection Error: Connection failed')

        expect { engine.extract(topic, article) }.to raise_error(RuntimeError, 'Connection Error: Connection failed')
      end
    end
  end
end