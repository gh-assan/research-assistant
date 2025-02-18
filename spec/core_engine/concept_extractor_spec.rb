# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::ConceptExtractor do
  let(:api_client) { instance_double(ResearchAssistant::OllamaInterface::ApiClient) }
  let(:json_api_client) { instance_double(ResearchAssistant::OllamaInterface::JsonApiClient) }
  let(:extractor) { described_class.new(api_client, json_api_client) }
  let(:text) { 'The sky is blue and the sun is bright.' }
  let(:topic) { 'This is a sample topic.' }
  let(:response_body) {
    [
      { 'concept' => 'sky', 'relevance' => 'foundational' },
      { 'concept' => 'blue', 'relevance' => 'critical' },
      { 'concept' => 'sun', 'relevance' => 'counterfactual' },
      { 'concept' => 'bright', 'relevance' => 'synthesis' }
    ]
  }

  describe '#extract' do
    context 'when the API request is successful' do
      it 'returns the extracted concepts' do
        allow(api_client).to receive(:query).and_return(response_body.to_json)
        allow(json_api_client).to receive(:query).with(response_body.to_json, ResearchAssistant::CoreEngine::Models::CONCEPTS_SCHEMA).and_return(response_body)

        concepts = extractor.extract(topic, text)
        expect(concepts).to be_an(Array)
        expect(concepts).not_to be_empty
        expect(concepts).to all(include('concept', 'relevance'))
      end
    end

    context 'when the API request fails' do
      it 'raises an API error' do
        allow(api_client).to receive(:query).and_raise(RuntimeError, 'API Error: Something went wrong')

        expect { extractor.extract(topic, text) }.to raise_error(RuntimeError, 'API Error: Something went wrong')
      end
    end

    context 'when there is a connection error' do
      it 'raises a connection error' do
        allow(api_client).to receive(:query).and_raise(RuntimeError, 'Connection Error: Connection failed')

        expect { extractor.extract(topic, text) }.to raise_error(RuntimeError, 'Connection Error: Connection failed')
      end
    end
  end
end