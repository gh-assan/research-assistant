# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::KnowledgeIntegrator do
  let(:insights_extractor) { instance_double(ResearchAssistant::CoreEngine::InsightsExtractor) }
  let(:concept_extractor) { instance_double(ResearchAssistant::CoreEngine::ConceptExtractor) }
  let(:gap_detector) { instance_double(ResearchAssistant::CoreEngine::GapDetector) }
  let(:integrator) { described_class.new(insights_extractor: insights_extractor, concept_extractor: concept_extractor, gap_detector: gap_detector) }
  let(:analysis) { { insights: [], core_concepts: [], knowledge_gaps: [] } }
  let(:topic) { 'sample topic' }
  let(:response) { 'This is a sample response.' }
  let(:insights) {
    [
      { 'insight' => 'The sky is blue.', 'classification' => 'foundational', 'significance' => 'It describes the color of the sky.' },
      { 'insight' => 'The sun is bright.', 'classification' => 'critical', 'significance' => 'It describes the brightness of the sun.' }
    ]
  }
  let(:concepts) {
    [
      { 'concept' => 'sky', 'relevance' => 'foundational' },
      { 'concept' => 'blue', 'relevance' => 'critical' }
    ]
  }
  let(:gaps) {
    [
      { 'insight' => 'Missing foundational concept.', 'classification' => 'foundational', 'significance' => 'It is crucial for the analysis.' }
    ]
  }

  describe '#integrate' do
    context 'when all API requests are successful' do
      it 'returns the integrated knowledge' do
        allow(insights_extractor).to receive(:analyze).with(topic, response).and_return(insights)
        allow(concept_extractor).to receive(:extract).with(topic, response).and_return(concepts)
        allow(gap_detector).to receive(:detect).with(analysis, response).and_return(gaps)

        knowledge = integrator.integrate(analysis, topic, response)

        expect(knowledge.insights).to eq(insights)
        expect(knowledge.concepts).to eq(concepts)
        expect(knowledge.knowledge_gaps).to eq(gaps)
      end
    end

    context 'when the insights extraction fails' do
      it 'raises an error' do
        allow(insights_extractor).to receive(:analyze).and_raise(RuntimeError, 'Insights extraction failed')

        expect { integrator.integrate(analysis, topic, response) }.to raise_error(RuntimeError, 'Insights extraction failed')
      end
    end

    context 'when the concept extraction fails' do
      it 'raises an error' do
        allow(insights_extractor).to receive(:analyze).with(topic, response).and_return(insights)
        allow(concept_extractor).to receive(:extract).and_raise(RuntimeError, 'Concept extraction failed')

        expect { integrator.integrate(analysis, topic, response) }.to raise_error(RuntimeError, 'Concept extraction failed')
      end
    end

    context 'when the gap detection fails' do
      it 'raises an error' do
        allow(insights_extractor).to receive(:analyze).with(topic, response).and_return(insights)
        allow(concept_extractor).to receive(:extract).with(topic, response).and_return(concepts)
        allow(gap_detector).to receive(:detect).and_raise(RuntimeError, 'Gap detection failed')

        expect { integrator.integrate(analysis, topic, response) }.to raise_error(RuntimeError, 'Gap detection failed')
      end
    end
  end
end