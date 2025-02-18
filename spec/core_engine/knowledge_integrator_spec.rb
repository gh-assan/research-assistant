# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::KnowledgeIntegrator do
  let(:insights_extractor) { instance_double(ResearchAssistant::CoreEngine::InsightsExtractor) }
  let(:concept_extractor) { instance_double(ResearchAssistant::CoreEngine::ConceptExtractor) }
  let(:gap_detector) { instance_double(ResearchAssistant::CoreEngine::GapDetector) }
  let(:questions_engine) { instance_double(ResearchAssistant::CoreEngine::QuestionEngine) }
  let(:relations_finder) { instance_double(ResearchAssistant::CoreEngine::RelationsFinder) }
  let(:integrator) { described_class.new(insights_extractor: insights_extractor, concept_extractor: concept_extractor, gap_detector: gap_detector, questions_engine: questions_engine, relations_finder: relations_finder) }
  let(:analysis) { { insights: [], core_concepts: [], knowledge_gaps: [] } }
  let(:topic) { 'sample topic' }
  let(:response) { 'This is a sample response.' }
  let(:user_intent) { 'Write a detailed article about climate change.' }
  let(:insights) { { 'insights' => ['Insight 1', 'Insight 2'] } }
  let(:concepts) { { 'concepts' => ['Concept 1', 'Concept 2'] } }
  let(:gaps) { { 'knowledge_gaps' => ['Gap 1', 'Gap 2'] } }
  let(:questions) { { 'questions' => ['Question 1', 'Question 2'] } }
  let(:relations) { { 'relations' => ['Relation 1', 'Relation 2'] } }

  describe '#integrate' do
    context 'when all API requests are successful' do
      it 'returns the integrated knowledge' do
        allow(insights_extractor).to receive(:analyze).with(topic, response).and_return(insights)
        allow(concept_extractor).to receive(:extract).with(topic, response).and_return(concepts)
        allow(gap_detector).to receive(:detect).with(analysis, response).and_return(gaps)
        allow(questions_engine).to receive(:extract).with(response).and_return(questions)
        allow(relations_finder).to receive(:find_relations).with(topic, response, analysis).and_return(relations)

        knowledge = integrator.integrate(analysis, topic, response, user_intent)

        expect(knowledge.insights).to eq(insights['insights'])
        expect(knowledge.concepts).to eq(concepts['concepts'])
        expect(knowledge.knowledge_gaps).to eq(gaps['knowledge_gaps'])
        expect(knowledge.questions).to eq(questions['questions'])
        expect(knowledge.relations).to eq(relations['relations'])
        expect(knowledge.user_intent).to eq(user_intent)
      end
    end

    context 'when the insights extraction fails' do
      it 'raises an error' do
        allow(insights_extractor).to receive(:analyze).and_raise(RuntimeError, 'Insights extraction failed')

        expect { integrator.integrate(analysis, topic, response, user_intent) }.to raise_error(RuntimeError, 'Insights extraction failed')
      end
    end

    context 'when the concept extraction fails' do
      it 'raises an error' do
        allow(insights_extractor).to receive(:analyze).with(topic, response).and_return(insights)
        allow(concept_extractor).to receive(:extract).and_raise(RuntimeError, 'Concept extraction failed')

        expect { integrator.integrate(analysis, topic, response, user_intent) }.to raise_error(RuntimeError, 'Concept extraction failed')
      end
    end

    context 'when the gap detection fails' do
      it 'raises an error' do
        allow(insights_extractor).to receive(:analyze).with(topic, response).and_return(insights)
        allow(concept_extractor).to receive(:extract).with(topic, response).and_return(concepts)
        allow(gap_detector).to receive(:detect).and_raise(RuntimeError, 'Gap detection failed')

        expect { integrator.integrate(analysis, topic, response, user_intent) }.to raise_error(RuntimeError, 'Gap detection failed')
      end
    end

    context 'when the questions extraction fails' do
      it 'raises an error' do
        allow(insights_extractor).to receive(:analyze).with(topic, response).and_return(insights)
        allow(concept_extractor).to receive(:extract).with(topic, response).and_return(concepts)
        allow(gap_detector).to receive(:detect).with(analysis, response).and_return(gaps)
        allow(questions_engine).to receive(:extract).and_raise(RuntimeError, 'Questions extraction failed')

        expect { integrator.integrate(analysis, topic, response, user_intent) }.to raise_error(RuntimeError, 'Questions extraction failed')
      end
    end

    context 'when the relations finding fails' do
      it 'raises an error' do
        allow(insights_extractor).to receive(:analyze).with(topic, response).and_return(insights)
        allow(concept_extractor).to receive(:extract).with(topic, response).and_return(concepts)
        allow(gap_detector).to receive(:detect).with(analysis, response).and_return(gaps)
        allow(questions_engine).to receive(:extract).with(response).and_return(questions)
        allow(relations_finder).to receive(:find_relations).and_raise(RuntimeError, 'Relations finding failed')

        expect { integrator.integrate(analysis, topic, response, user_intent) }.to raise_error(RuntimeError, 'Relations finding failed')
      end
    end
  end
end