require 'spec_helper'
require 'faraday'
require 'json'

RSpec.describe ResearchAssistant::OllamaInterface::JsonApiClient do
  let(:model) { 'test_model' }
  let(:api_url) { 'http://api.example.com' }
  let(:api_client) { described_class.new(model: model) }
  let(:prompt) { 'Test prompt' }
  let(:schema) { 'Test schema' }
  let(:response_body) { { 'response' => '{"key": "value"}' }.to_json }
  let(:parsed_response) { { 'key' => 'value' } }

  before do
    allow(ResearchAssistant.config).to receive(:json_model).and_return(model)
    allow(ResearchAssistant.config).to receive(:ollama_url).and_return(api_url)
  end

  describe '#query' do
    context 'when the API call is successful' do
      before do
        stub_request(:post, "#{api_url}/api/generate")
          # .with(
          #   body: {
          #     model: model,
          #     prompt: "#{prompt} #{schema}",
          #     stream: false
          #   }.to_json,
          #   headers: { 'Content-Type' => 'application/json' }
          # )
          .to_return(status: 200, body: response_body, headers: { 'Content-Type' => 'application/json' })
      end

      it 'returns the parsed JSON response' do
        result = api_client.query(prompt, schema)
        expect(result).to eq(parsed_response)
      end
    end

    context 'when the response is not valid JSON' do
      let(:invalid_response_body) { { 'response' => 'Invalid JSON' }.to_json }

      before do
        stub_request(:post, "#{api_url}/api/generate")
          .to_return(status: 200, body: invalid_response_body, headers: { 'Content-Type' => 'application/json' })
      end

      it 'raises a JSON parsing error' do
        expect { api_client.query(prompt, schema) }.to raise_error(RuntimeError, /JSON Parsing Error/)
      end
    end
  end
end