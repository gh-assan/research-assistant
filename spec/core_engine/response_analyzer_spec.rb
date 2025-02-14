require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::ResponseAnalyzer do
  let(:mock_api_client) { instance_double('ResearchAssistant::OllamaInterface::ApiClient') }
  let(:analyzer) { described_class.new(mock_api_client) }

  describe '#analyze' do
    it 'extracts insights from the response using the API client' do
      response = "This is a sample response."
      analysis = { insights: [] }
      api_response = { 'insights' => ['Insight 1', 'Insight 2'] }.to_json

      expect(mock_api_client).to receive(:query).with("Analyze the following response and extract key insights:\n\n#{response}\n\nInsights:").and_return(api_response)

      result = analyzer.analyze(response, analysis)

      expect(result[:insights]).to include('Insight 1', 'Insight 2')
    end
  end
end