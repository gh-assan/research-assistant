require 'spec_helper'
require 'fileutils'

RSpec.describe ResearchAssistant::KnowledgeBase::BrainstormingFileManager do
  let(:research_id) { SecureRandom.uuid }
  let(:base_path) { File.join(ResearchAssistant.config.research_dir, research_id) }
  let(:brainstorming_file_manager) { described_class.new(research_id) }
  let(:brainstorming_data) do
    instance_double(
      ResearchAssistant::KnowledgeBase::BrainstormingData,
      summary: "Summary content",
      multi_personals: "MultiPersonals content",
      deep_dive: "DeepDive content",
      reverse_brainstorming: "ReverseBrainstorming content",
      future_vision: "FutureVision content",
      mind_mapping: "MindMapping content",
      scamper_method: "ScamperMethod content"
    )
  end
  let(:iteration_number) { 1 }
  let(:iteration_dir) { File.join(base_path, "iterations/#{iteration_number}") }

  before do
    allow(FileUtils).to receive(:mkdir_p)
    allow(File).to receive(:write)
  end

  describe '#save_iteration' do
    it 'creates the necessary directories and saves the brainstorming data' do
      brainstorming_file_manager.save_iteration(brainstorming_data, iteration_number)

      expect(FileUtils).to have_received(:mkdir_p).with(base_path)
      expect(FileUtils).to have_received(:mkdir_p).with(iteration_dir)
      expect(File).to have_received(:write).with(File.join(iteration_dir, "summary.md"), "Summary content")
      expect(File).to have_received(:write).with(File.join(iteration_dir, "multi_personals.md"), "MultiPersonals content")
      expect(File).to have_received(:write).with(File.join(iteration_dir, "deep_dive.md"), "DeepDive content")
      expect(File).to have_received(:write).with(File.join(iteration_dir, "reverse_brainstorming.md"), "ReverseBrainstorming content")
      expect(File).to have_received(:write).with(File.join(iteration_dir, "future_vision.md"), "FutureVision content")
      expect(File).to have_received(:write).with(File.join(iteration_dir, "mind_mapping.md"), "MindMapping content")
      expect(File).to have_received(:write).with(File.join(iteration_dir, "scamper_method.md"), "ScamperMethod content")
    end
  end
end