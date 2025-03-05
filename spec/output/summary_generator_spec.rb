require 'spec_helper'

RSpec.describe ResearchAssistant::Output::SummaryGenerator do
  let(:write_api_client) { instance_double(ResearchAssistant::OllamaInterface::WriterApiClient) }
  let(:summary_generator) { described_class.new(write_api_client) }
  let(:brainstorming_data) do
    instance_double(
      ResearchAssistant::KnowledgeBase::BrainstormingData,
      topic: "The impact of artificial intelligence on society",
      scamper_method: "ScamperMethod content",
      multi_personals: "MultiPersonals content",
      deep_dive: "DeepDive content",
      reverse_brainstorming: "ReverseBrainstorming content",
      future_vision: "FutureVision content",
      mind_mapping: "MindMapping content",
      last_round_summary: "Summary of the last round"
    )
  end

  let(:summary) { "Generated summary" }

  describe '#generate_summary' do
    it 'generates a summary based on the brainstorming data' do
      allow(write_api_client).to receive(:write_article).and_return(summary)

      result = summary_generator.generate_summary(brainstorming_data)

      expect(result).to eq(summary)
      expect(write_api_client).to have_received(:write_article)
    end

    it 'raises an error if the summary generation fails' do
      allow(write_api_client).to receive(:write_article).and_raise(StandardError.new("API error"))

      expect { summary_generator.generate_summary(brainstorming_data) }.to raise_error("Failed to generate Brainstorming summary : API error")
    end
  end
end