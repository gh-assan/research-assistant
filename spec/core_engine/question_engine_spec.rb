# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::QuestionEngine do
  let(:api_client) { instance_double(ResearchAssistant::OllamaInterface::ApiClient) }
  let(:json_api_client) { instance_double(ResearchAssistant::OllamaInterface::JsonApiClient) }
  let(:engine) { described_class.new(api_client, json_api_client) }
  let(:text) { 'The sky is blue and the sun is bright.' }
  let(:api_response) {
    [
      { 'type' => 'foundational', 'question' => 'What is the color of the sky?', 'priority' => 'high', 'relevance' => 'foundational', 'explanation' => 'It addresses the basic principle of the text.' },
      { 'type' => 'critical', 'question' => 'Why is the sun bright?', 'priority' => 'medium', 'relevance' => 'critical', 'explanation' => 'It examines the strength of the idea presented.' }
    ]
  }

  describe '#extract' do
    context 'when the API request is successful' do
      it 'returns the generated questions' do
        allow(api_client).to receive(:query).and_return(api_response.to_json)
        allow(json_api_client).to receive(:query).with(api_response.to_json, ResearchAssistant::CoreEngine::Models::QUESTIONS_SCHEMA).and_return(api_response)

        questions = engine.extract(text)
        expect(questions).to be_an(Array)
        expect(questions).not_to be_empty
        expect(questions).to all(include('type', 'question', 'priority', 'relevance', 'explanation'))
      end
    end

    context 'when the API request fails' do
      it 'raises an API error' do
        allow(api_client).to receive(:query).and_raise(RuntimeError, 'API Error: Something went wrong')

        expect { engine.extract(text) }.to raise_error(RuntimeError, 'API Error: Something went wrong')
      end
    end

    context 'when there is a connection error' do
      it 'raises a connection error' do
        allow(api_client).to receive(:query).and_raise(RuntimeError, 'Connection Error: Connection failed')

        expect { engine.extract(text) }.to raise_error(RuntimeError, 'Connection Error: Connection failed')
      end
    end
  end
end