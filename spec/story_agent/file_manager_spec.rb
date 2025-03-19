require 'spec_helper'
require 'fileutils'

RSpec.describe ResearchAssistant::StoryAgent::FileManager do
  let(:story_id) { 'sample_story_id' }
  let(:base_path) { File.join(ResearchAssistant.config.story_dir, story_id) }
  let(:file_manager) { described_class.new(story_id) }
  let(:story) { 'This is the story content.' }
  let(:action) { instance_double('Action', to_command: 'enhance_story') }
  let(:iteration) { 1 }
  let(:iteration_dir) { File.join(base_path, "iterations/#{iteration}") }

  before do
    allow(FileUtils).to receive(:mkdir_p)
    allow(File).to receive(:write)
  end

  describe '#save_iteration' do
    it 'creates the iteration directory' do
      file_manager.save_iteration(story, iteration, action)

      expect(FileUtils).to have_received(:mkdir_p).with(iteration_dir)
    end

    it 'saves the story to a .md file' do
      file_manager.save_iteration(story, iteration, action)

      expect(File).to have_received(:write).with(File.join(iteration_dir, 'story.md'), story)
    end

    it 'saves the action to a .md file' do
      file_manager.save_iteration(story, iteration, action)

      expect(File).to have_received(:write).with(File.join(iteration_dir, 'action.md'), action.to_command)
    end
  end
end