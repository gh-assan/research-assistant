require 'spec_helper'

RSpec.describe ResearchAssistant::Agent::ArticleEnhancer do
  let(:write_api_client) { instance_double(ResearchAssistant::OllamaInterface::WriterApiClient) }
  let(:article_enhancer) { described_class.new(write_api_client) }
  let(:article) { "This is the original article content." }
  let(:executed_action) { "extract_insights" }
  let(:analysis_output) { "Analysis result indicating improvements." }
  let(:prompt) { "Formatted prompt content (ignored in test)." }
  let(:enhanced_article) { "This is the enhanced article content." }

  before do
    allow(write_api_client).to receive(:write_article).and_return(enhanced_article)
    allow(article_enhancer).to receive(:format).and_return(prompt) # Stub format to ignore PROMPT value
  end

  describe '#enhance' do
    it 'enhances the article based on the executed action and analysis output' do
      result = article_enhancer.enhance(article, executed_action, analysis_output)

      expect(result).to eq(enhanced_article)
      expect(write_api_client).to have_received(:write_article).with(prompt)
    end

    context 'when the write_article method raises an error' do
      it 'raises a descriptive error' do
        allow(write_api_client).to receive(:write_article).and_raise(StandardError, "API error")

        expect {
          article_enhancer.enhance(article, executed_action, analysis_output)
        }.to raise_error(RuntimeError, "Failed to generate article: API error")
      end
    end
  end
end