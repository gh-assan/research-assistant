require 'spec_helper'

RSpec.describe ResearchAssistant::CoreEngine::QuestionEngine do
  let(:api_client) { instance_double('OllamaInterface::ApiClient') }
  let(:engine) { described_class.new(api_client: api_client) }

  describe '#generate_questions' do
    it 'generates questions based on analysis' do
      analysis = {
        core_concepts: ["Quantum Computing", "Machine Learning"],
        relationships: [
          { source: "Quantum Computing", target: "Machine Learning", type: "related" }
        ]
      }

      questions = engine.generate_questions(analysis)
      expect(questions).to all(include(:text, :type, :depth_level, :target_concepts))
    end
  end
end