require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::GapDetector do
  let(:api_client) { instance_double(ResearchAssistant::OllamaInterface::ApiClient) }
  let(:detector) { described_class.new(api_client: api_client) }

  describe '#detect' do
    it 'detects knowledge gaps from the analysis and response using the API client' do
      analysis = { insights: [], core_concepts: [], knowledge_gaps: [] }
      response = "This is a sample response."
      api_response = [
        { 'text' => 'Gap 1', 'severity' => 'high' },
        { 'text' => 'Gap 2', 'severity' => 'medium' }
      ].to_json

      expect(api_client).to receive(:query).with("Identify knowledge gaps in the following analysis based on the response: #{response}\n\nAnalysis: #{analysis}").and_return(api_response)

      result = detector.detect(analysis, response)

      expect(result).to include({ gap: 'Gap 1', severity: 'high' }, { gap: 'Gap 2', severity: 'medium' })
    end
  end
end