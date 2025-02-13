# frozen_string_literal: true

require 'spec_helper'
RSpec.describe ResearchAssistant::CoreEngine::ConceptExtractor do
  let(:api_client) { instance_double(ResearchAssistant::OllamaInterface::ApiClient) }
  let(:extractor) { described_class.new(api_client: api_client) }
  let(:text) { 'The sky is blue and the sun is bright.' }
  let(:response_body) {
    [
      { 'text' => 'sky', 'relevance' => 0.9 },
      { 'text' => 'blue', 'relevance' => 0.8 },
      { 'text' => 'sun', 'relevance' => 0.85 },
      { 'text' => 'bright', 'relevance' => 0.75 }
    ].to_json
  }

  describe '#extract' do
    context 'when the API request is successful' do
      it 'returns the extracted concepts' do
        allow(api_client).to receive(:query).and_return(response_body)

        concepts = extractor.extract(text)
        expect(concepts).to be_an(Array)
        expect(concepts).not_to be_empty
        expect(concepts).to all(include(:concept, :relevance))
      end
    end

    context 'when the API request fails' do
      it 'raises an API error' do
        allow(api_client).to receive(:query).and_raise(RuntimeError, 'API Error: Something went wrong')

        expect { extractor.extract(text) }.to raise_error(RuntimeError, 'API Error: Something went wrong')
      end
    end

    context 'when there is a connection error' do
      it 'raises a connection error' do
        allow(api_client).to receive(:query).and_raise(RuntimeError, 'Connection Error: Connection failed')

        expect { extractor.extract(text) }.to raise_error(RuntimeError, 'Connection Error: Connection failed')
      end
    end
  end
end