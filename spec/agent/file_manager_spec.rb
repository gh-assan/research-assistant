require 'spec_helper'
require 'fileutils'

RSpec.describe ResearchAssistant::Agent::FileManager do
  let(:research_id) { 'sample_research_id' }
  let(:base_path) { File.join(ResearchAssistant.config.research_dir, research_id) }
  let(:file_manager) { described_class.new(research_id) }
  let(:article) { 'This is the article content.' }
  let(:action) { instance_double('Action', to_command: 'extract_insights') }
  let(:analysis_output) { 'This is the analysis output.' }
  let(:iteration) { 1 }
  let(:iteration_dir) { File.join(base_path, "iterations/#{iteration}") }

  before do
    allow(FileUtils).to receive(:mkdir_p)
    allow(File).to receive(:write)
  end

  describe '#save_iteration' do
    it 'creates the iteration directory' do
      file_manager.save_iteration(article, iteration, action, analysis_output)

      expect(FileUtils).to have_received(:mkdir_p).with(iteration_dir)
    end

    it 'saves the article to a .md file' do
      file_manager.save_iteration(article, iteration, action, analysis_output)

      expect(File).to have_received(:write).with(File.join(iteration_dir, 'article.md'), article)
    end

    it 'saves the action to a .md file' do
      file_manager.save_iteration(article, iteration, action, analysis_output)

      expect(File).to have_received(:write).with(File.join(iteration_dir, 'action.md'), action.to_command)
    end

    it 'saves the analysis output to a .md file' do
      file_manager.save_iteration(article, iteration, action, analysis_output)

      expect(File).to have_received(:write).with(File.join(iteration_dir, 'analysis_output.md'), analysis_output)
    end
  end
end