require 'spec_helper'
# require 'faraday'

RSpec.describe ResearchAssistant::OllamaInterface::ReasoningClient do
  let(:model) { 'deepseek-coder' }
  let(:ollama_url) { 'http://localhost:11434' }
  let(:client) { described_class.new(model: model) }
  let(:prompt) { 'Why is the sky blue?' }

  before do
    allow(ResearchAssistant.config).to receive(:ollama_url).and_return(ollama_url)
  end

  describe '#query' do
    context 'when the API request is successful' do
      it 'returns the response' do
        response_body = { 'response' => 'The sky is blue because of Rayleigh scattering.' }
        stub_request(:post, "#{ollama_url}/api/generate")
          .with(body: { model: model, prompt: prompt, stream: false }.to_json)
          .to_return(status: 200, body: response_body.to_json, headers: { 'Content-Type' => 'application/json' })

        response = client.query(prompt)
        expect(response).to eq('The sky is blue because of Rayleigh scattering.')
      end
    end

    context 'when the API request fails' do
      it 'raises an API error' do
        response_body = { 'error' => 'Something went wrong' }
        stub_request(:post, "#{ollama_url}/api/generate")
          .with(body: { model: model, prompt: prompt, stream: false }.to_json)
          .to_return(status: 500, body: response_body.to_json, headers: { 'Content-Type' => 'application/json' })

        expect { client.query(prompt) }.to raise_error(RuntimeError, 'API Error: Something went wrong')
      end
    end

    context 'when there is a connection error' do
      it 'raises a connection error' do
        stub_request(:post, "#{ollama_url}/api/generate")
          .with(body: { model: model, prompt: prompt, stream: false }.to_json)
          .to_raise(Faraday::ConnectionFailed.new('Connection failed'))

        expect { client.query(prompt) }.to raise_error(RuntimeError, 'Connection Error: Connection failed')
      end
    end
  end
end