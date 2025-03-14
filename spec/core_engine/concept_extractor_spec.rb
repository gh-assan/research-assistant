# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::ConceptExtractor do
  let(:api_client) { instance_double(ResearchAssistant::OllamaInterface::ApiClient) }
  let(:extractor) { described_class.new }
  let(:topic) { 'This is a sample topic.' }
  let(:article) { 'The sky is blue and the sun is bright.' }
  let(:prompt) do
    <<~PROMPT
      Topic: #{topic}
      Article: #{article}
    PROMPT
  end
  let(:response) { "Extracted concepts" }

  before do
    allow(ResearchAssistant::OllamaInterface::ApiClient).to receive(:new).with('research-assistant-concept-extractor-model').and_return(api_client)
    allow(api_client).to receive(:query).with(prompt).and_return(response)
  end

  describe '#extract' do
    it 'extracts concepts from the given topic and article' do
      result = extractor.extract(topic, article)
      expect(result).to eq(response)
      expect(api_client).to have_received(:query).with(prompt)
    end

    context 'when the API request fails' do
      it 'raises an API error' do
        allow(api_client).to receive(:query).with(prompt).and_raise(RuntimeError, 'API Error: Something went wrong')

        expect { extractor.extract(topic, article) }.to raise_error(RuntimeError, 'API Error: Something went wrong')
      end
    end

    context 'when there is a connection error' do
      it 'raises a connection error' do
        allow(api_client).to receive(:query).with(prompt).and_raise(RuntimeError, 'Connection Error: Connection failed')

        expect { extractor.extract(topic, article) }.to raise_error(RuntimeError, 'Connection Error: Connection failed')
      end
    end
  end
end