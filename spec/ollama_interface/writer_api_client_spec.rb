# frozen_string_literal: true

require 'spec_helper'
require 'faraday'

RSpec.describe ResearchAssistant::OllamaInterface::WriterApiClient do
  let(:model) { 'sample_model' }
  let(:ollama_url) { 'http://example.com' }
  let(:config) { double('config', writer_model: model, ollama_url: ollama_url) }
  let(:client) { described_class.new(model: model) }
  let(:prompt) { 'Write an article about climate change.' }
  let(:response_body) { { 'response' => 'Generated article content.' } }
  let(:error_response_body) { { 'error' => 'Something went wrong' } }

  before do
    allow(ResearchAssistant).to receive(:config).and_return(config)
  end

  describe '#write_article' do
    context 'when the API request is successful' do
      it 'returns the generated article content' do
        stub_request(:post, "#{ollama_url}/api/generate")
          .with(
            body: {
              model: model,
              prompt: prompt,
              stream: false
            }.to_json,
            headers: { 'Content-Type' => 'application/json' }
          )
          .to_return(status: 200, body: response_body.to_json, headers: { 'Content-Type' => 'application/json' })

        article = client.write_article(prompt)
        expect(article).to eq('Generated article content.')
      end
    end

    context 'when the API request fails' do
      it 'raises an API error' do
        stub_request(:post, "#{ollama_url}/api/generate")
          .with(
            body: {
              model: model,
              prompt: prompt,
              stream: false
            }.to_json,
            headers: { 'Content-Type' => 'application/json' }
          )
          .to_return(status: 500, body: error_response_body.to_json, headers: { 'Content-Type' => 'application/json' })

        expect { client.write_article(prompt) }.to raise_error(RuntimeError, 'API Error: Something went wrong')
      end
    end

    context 'when there is a connection error' do
      it 'raises a connection error' do
        stub_request(:post, "#{ollama_url}/api/generate")
          .with(
            body: {
              model: model,
              prompt: prompt,
              stream: false
            }.to_json,
            headers: { 'Content-Type' => 'application/json' }
          )
          .to_raise(Faraday::ConnectionFailed.new('Connection failed'))

        expect { client.write_article(prompt) }.to raise_error(RuntimeError, 'Connection Error: Connection failed')
      end
    end
  end
end