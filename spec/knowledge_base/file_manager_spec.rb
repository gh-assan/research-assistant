# frozen_string_literal: true

require 'spec_helper'
require 'fileutils'

RSpec.describe ResearchAssistant::KnowledgeBase::FileManager do
  let(:research_id) { 'sample_research_id' }
  let(:base_path) { File.join(ResearchAssistant.config.research_dir, research_id) }
  let(:file_manager) { described_class.new(research_id) }
  let(:knowledge) do
    ResearchAssistant::KnowledgeBase::Knowledge.new(
      insights: ['Insight 1', 'Insight 2'].to_s,
      concepts: ['Concept 1', 'Concept 2'].to_s,
      relations: ['Relation 1', 'Relation 2'].to_s,
      knowledge_gaps: ['Gap 1', 'Gap 2'].to_s,
      questions: ['Question 1', 'Question 2'].to_s,
      article: 'This is the article content.',
      iteration: 1
    )
  end
  let(:iteration_dir) { File.join(base_path, "iterations/#{knowledge.iteration}") }

  before do
    allow(FileUtils).to receive(:mkdir_p)
    allow(File).to receive(:write)
  end

  describe '#save_iteration' do
    it 'creates the iteration directory' do
      file_manager.save_iteration(knowledge)
      expect(FileUtils).to have_received(:mkdir_p).with(iteration_dir)
    end

    it 'saves the article to a .md file' do
      file_manager.save_iteration(knowledge)
      expect(File).to have_received(:write).with(File.join(iteration_dir, 'article.md'), knowledge.article)
    end

    it 'saves the questions to a .json file' do
      file_manager.save_iteration(knowledge)
      expect(File).to have_received(:write).with(File.join(iteration_dir, 'questions.md'), knowledge.questions)
    end

    it 'saves the concepts to a .json file' do
      file_manager.save_iteration(knowledge)
      expect(File).to have_received(:write).with(File.join(iteration_dir, 'concepts.md'), knowledge.concepts)
    end

    it 'saves the insights to a .json file' do
      file_manager.save_iteration(knowledge)
      expect(File).to have_received(:write).with(File.join(iteration_dir, 'insights.md'), knowledge.insights)
    end

    it 'saves the knowledge gaps to a .json file' do
      file_manager.save_iteration(knowledge)
      expect(File).to have_received(:write).with(File.join(iteration_dir, 'knowledge_gaps.md'), knowledge.knowledge_gaps)
    end

    it 'saves the relations to a .json file' do
      file_manager.save_iteration(knowledge)
      expect(File).to have_received(:write).with(File.join(iteration_dir, 'relations.md'), knowledge.relations)
    end
  end
end