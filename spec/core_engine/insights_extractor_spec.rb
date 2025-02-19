# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::InsightsExtractor do
  let(:api_client) { instance_double(ResearchAssistant::OllamaInterface::ApiClient) }
  let(:json_api_client) { instance_double(ResearchAssistant::OllamaInterface::JsonApiClient) }
  let(:analyzer) { described_class.new(api_client, json_api_client) }
  let(:text) { 'The sky is blue and the sun is bright.' }
  let(:topic) { 'sample topic.' }
  let(:response_body) {
    {
      'insights' => [
        { 'insight' => 'The sky is blue.', 'classification' => 'foundational', 'significance' => 'It describes the color of the sky.' },
        { 'insight' => 'The sun is bright.', 'classification' => 'critical', 'significance' => 'It describes the brightness of the sun.' }
      ]
    }
  }

  describe '#analyze' do
    context 'when the API request is successful' do
      it 'returns the analysis with extracted insights' do
        allow(api_client).to receive(:query).and_return(response_body.to_json)
        allow(json_api_client).to receive(:query).with(response_body.to_json, ResearchAssistant::CoreEngine::Models::INSIGHTS_SCHEMA).and_return(response_body)

        result = analyzer.analyze(topic, text)
        expect(result).to be_a(Array)
        expect(result).not_to be_empty
        expect(result).to all(include('insight', 'classification', 'significance'))
      end
    end

    context 'when the API request fails' do
      it 'raises an API error' do
        allow(api_client).to receive(:query).and_raise(RuntimeError, 'API Error: Something went wrong')

        expect { analyzer.analyze(topic, text) }.to raise_error(RuntimeError, 'API Error: Something went wrong')
      end
    end

    context 'when there is a connection error' do
      it 'raises a connection error' do
        allow(api_client).to receive(:query).and_raise(RuntimeError, 'Connection Error: Connection failed')

        expect { analyzer.analyze(topic, text) }.to raise_error(RuntimeError, 'Connection Error: Connection failed')
      end
    end
  end
end