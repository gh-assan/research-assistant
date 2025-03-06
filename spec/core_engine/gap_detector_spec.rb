# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::GapDetector do
  let(:brainstorming_api_client) { instance_double(ResearchAssistant::OllamaInterface::ReasoningClient) }
  let(:json_api_client) { instance_double(ResearchAssistant::OllamaInterface::JsonApiClient) }
  let(:detector) { described_class.new(brainstorming_api_client, json_api_client) }
  let(:analysis) { { insights: [], core_concepts: [], knowledge_gaps: [] } }
  let(:response) { 'This is a sample response.' }
  let(:api_response) {
    {
      'knowledge_gaps' => [
        { 'insight' => 'Missing foundational concept.', 'classification' => 'foundational', 'significance' => 'It is crucial for the analysis.' },
        { 'insight' => 'Lack of critical analysis.', 'classification' => 'critical', 'significance' => 'It is important for thorough understanding.' }
      ]
    }
  }

  describe '#detect' do
    context 'when the API request is successful' do
      it 'returns the detected knowledge gaps' do
        allow(brainstorming_api_client).to receive(:query).and_return(api_response.to_json)
        allow(json_api_client).to receive(:query).with(api_response.to_json, ResearchAssistant::CoreEngine::GapDetector::GAPS_SCHEMA).and_return(api_response)

        gaps = detector.detect(analysis, response)
        expect(gaps).to be_a(Array)
        expect(gaps).not_to be_empty
        expect(gaps).to all(include('insight', 'classification', 'significance'))
      end
    end

    context 'when the API request fails' do
      it 'raises an API error' do
        allow(brainstorming_api_client).to receive(:query).and_raise(RuntimeError, 'API Error: Something went wrong')

        expect { detector.detect(analysis, response) }.to raise_error(RuntimeError, 'API Error: Something went wrong')
      end
    end

    context 'when there is a connection error' do
      it 'raises a connection error' do
        allow(brainstorming_api_client).to receive(:query).and_raise(RuntimeError, 'Connection Error: Connection failed')

        expect { detector.detect(analysis, response) }.to raise_error(RuntimeError, 'Connection Error: Connection failed')
      end
    end
  end
end