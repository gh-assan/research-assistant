# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::RelationsFinder do
  let(:api_client) { instance_double(ResearchAssistant::OllamaInterface::ApiClient) }
  let(:json_api_client) { instance_double(ResearchAssistant::OllamaInterface::JsonApiClient) }
  let(:finder) { described_class.new(api_client, json_api_client) }
  let(:text) { 'The sky is blue and the sun is bright.' }
  let(:topic) { 'sample topic.' }
  let(:analysis) { { insights: [], core_concepts: [], knowledge_gaps: [] } }
  let(:api_response) {
    {
      'relationships' => [
        { 'insight' => 'The sky is blue.', 'classification' => 'associative', 'significance' => 'It describes the color of the sky.' },
        { 'insight' => 'The sun is bright.', 'classification' => 'causal', 'significance' => 'It describes the brightness of the sun.' }
      ]
    }
  }

  describe '#find_relations' do
    context 'when the API request is successful' do
      it 'returns the identified relationships' do
        allow(api_client).to receive(:query).and_return(api_response.to_json)
        allow(json_api_client).to receive(:query).with(api_response.to_json, ResearchAssistant::CoreEngine::Models::RELATIONS_SCHEMA).and_return(api_response)

        relations = finder.find_relations(topic, text, analysis)
        expect(relations).to be_a(Array)
        expect(relations).not_to be_empty
        expect(relations).to all(include('insight', 'classification', 'significance'))
      end
    end

    context 'when the API request fails' do
      it 'raises an API error' do
        allow(api_client).to receive(:query).and_raise(RuntimeError, 'API Error: Something went wrong')

        expect { finder.find_relations(topic, text, analysis) }.to raise_error(RuntimeError, 'API Error: Something went wrong')
      end
    end

    context 'when there is a connection error' do
      it 'raises a connection error' do
        allow(api_client).to receive(:query).and_raise(RuntimeError, 'Connection Error: Connection failed')

        expect { finder.find_relations(topic, text, analysis) }.to raise_error(RuntimeError, 'Connection Error: Connection failed')
      end
    end
  end
end