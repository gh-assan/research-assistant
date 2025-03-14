# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::RelationsFinder do
  let(:api_client) { instance_double(ResearchAssistant::OllamaInterface::ApiClient) }
  let(:json_api_client) { instance_double(ResearchAssistant::OllamaInterface::JsonApiClient) }
  let(:finder) { described_class.new }
  let(:article) { 'The sky is blue and the sun is bright.' }
  let(:topic) { 'sample topic.' }
  let(:prompt) do
    <<~PROMPT
      Topic: #{topic}
      Article: #{article}
    PROMPT
  end
  let(:api_response) {
    {
      'relationships' => [
        { 'insight' => 'The sky is blue.', 'classification' => 'associative', 'significance' => 'It describes the color of the sky.' },
        { 'insight' => 'The sun is bright.', 'classification' => 'causal', 'significance' => 'It describes the brightness of the sun.' }
      ]
    }
  }
  let(:response) { api_response.to_json }

  before do
    allow(ResearchAssistant::OllamaInterface::ApiClient).to receive(:new).with('research-assistant-relation-finder-model').and_return(api_client)
    allow(api_client).to receive(:query).with(prompt).and_return(response)
  end

  describe '#extract' do
    context 'when the API request is successful' do
      it 'returns the identified relationships' do
        relations = finder.extract(topic, article)
        expect(relations).not_to be_empty
        expect(relations).to include('relationships')
      end
    end

    context 'when the API request fails' do
      it 'raises an API error' do
        allow(api_client).to receive(:query).and_raise(RuntimeError, 'API Error: Something went wrong')

        expect { finder.extract(topic, article) }.to raise_error(RuntimeError, 'API Error: Something went wrong')
      end
    end

    context 'when there is a connection error' do
      it 'raises a connection error' do
        allow(api_client).to receive(:query).and_raise(RuntimeError, 'Connection Error: Connection failed')

        expect { finder.extract(topic, article) }.to raise_error(RuntimeError, 'Connection Error: Connection failed')
      end
    end
  end
end