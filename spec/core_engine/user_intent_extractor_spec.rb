# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::UserIntentExtractor do
  let(:json_api_client) { instance_double(ResearchAssistant::OllamaInterface::JsonApiClient) }
  let(:extractor) { described_class.new(json_api_client) }
  let(:text) { 'Create a scientific article about the effects of climate change.' }
  let(:api_response) {
    {
      'scientific_article_prompt' => 'Write a scientific article discussing the various effects of climate change on global weather patterns.'
    }
  }

  describe '#create_prompt' do
    context 'when the API request is successful' do
      it 'returns the scientific article prompt' do
        allow(json_api_client).to receive(:query).with(text, ResearchAssistant::CoreEngine::Models::USER_INTENT_SCHEMA).and_return(api_response)

        prompt = extractor.create_prompt(text)
        expect(prompt).to eq('Write a scientific article discussing the various effects of climate change on global weather patterns.')
      end
    end

    context 'when the API request fails' do
      it 'raises an API error' do
        allow(json_api_client).to receive(:query).and_raise(RuntimeError, 'API Error: Something went wrong')

        expect { extractor.create_prompt(text) }.to raise_error(RuntimeError, 'API Error: Something went wrong')
      end
    end

    context 'when there is a connection error' do
      it 'raises a connection error' do
        allow(json_api_client).to receive(:query).and_raise(RuntimeError, 'Connection Error: Connection failed')

        expect { extractor.create_prompt(text) }.to raise_error(RuntimeError, 'Connection Error: Connection failed')
      end
    end
  end
end