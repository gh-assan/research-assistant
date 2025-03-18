require 'spec_helper'

RSpec.describe ResearchAssistant::Agent::AgentActionExecutor do
  let(:insights_extractor) { instance_double(ResearchAssistant::CoreEngine::InsightsExtractor) }
  let(:concept_extractor) { instance_double(ResearchAssistant::CoreEngine::ConceptExtractor) }
  let(:gap_detector) { instance_double(ResearchAssistant::CoreEngine::GapDetector) }
  let(:questions_engine) { instance_double(ResearchAssistant::CoreEngine::QuestionEngine) }
  let(:relations_finder) { instance_double(ResearchAssistant::CoreEngine::RelationsFinder) }
  let(:generic_command) { instance_double(ResearchAssistant::CoreEngine::GenericCommand) }
  let(:executor) do
    described_class.new(
      insights_extractor: insights_extractor,
      concept_extractor: concept_extractor,
      gap_detector: gap_detector,
      questions_engine: questions_engine,
      relations_finder: relations_finder,
      generic_command: generic_command
    )
  end
  let(:topic) { "Sample Topic" }
  let(:article) { "This is a sample article content." }

  describe '#run' do
    context 'when the action is "extract_insights"' do
      let(:action) { instance_double("Action", name: "extract_insights") }

      it 'calls the insights_extractor' do
        allow(insights_extractor).to receive(:extract).with(topic, article).and_return("Insights extracted")

        result = executor.run(action, topic, article)

        expect(result).to eq("Insights extracted")
        expect(insights_extractor).to have_received(:extract).with(topic, article)
      end
    end

    context 'when the action is "extract_concepts"' do
      let(:action) { instance_double("Action", name: "extract_concepts") }

      it 'calls the concept_extractor' do
        allow(concept_extractor).to receive(:extract).with(topic, article).and_return("Concepts extracted")

        result = executor.run(action, topic, article)

        expect(result).to eq("Concepts extracted")
        expect(concept_extractor).to have_received(:extract).with(topic, article)
      end
    end

    context 'when the action is "detect_gaps"' do
      let(:action) { instance_double("Action", name: "detect_gaps") }

      it 'calls the gap_detector' do
        allow(gap_detector).to receive(:extract).with(topic, article).and_return("Gaps detected")

        result = executor.run(action, topic, article)

        expect(result).to eq("Gaps detected")
        expect(gap_detector).to have_received(:extract).with(topic, article)
      end
    end

    context 'when the action is "generate_questions"' do
      let(:action) { instance_double("Action", name: "generate_questions") }

      it 'calls the questions_engine' do
        allow(questions_engine).to receive(:extract).with(topic, article).and_return("Questions generated")

        result = executor.run(action, topic, article)

        expect(result).to eq("Questions generated")
        expect(questions_engine).to have_received(:extract).with(topic, article)
      end
    end

    context 'when the action is "find_relations"' do
      let(:action) { instance_double("Action", name: "find_relations") }

      it 'calls the relations_finder' do
        allow(relations_finder).to receive(:extract).with(topic, article).and_return("Relations found")

        result = executor.run(action, topic, article)

        expect(result).to eq("Relations found")
        expect(relations_finder).to have_received(:extract).with(topic, article)
      end
    end

    context 'when the action is unknown' do
      let(:action) { instance_double("Action", name: "unknown_action", to_command: "custom command") }

      it 'calls the generic_command' do
        allow(generic_command).to receive(:extract).with("#{topic} custom command", article).and_return("Generic command executed")

        result = executor.run(action, topic, article)

        expect(result).to eq("Generic command executed")
        expect(generic_command).to have_received(:extract).with("#{topic} custom command", article)
      end
    end
  end
end