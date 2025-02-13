#!/usr/bin/env ruby
require 'research_assistant'

def main
  topic = ARGV[0] || raise("Usage: research <topic>")
  research_id = SecureRandom.uuid

  # Initialize components
  api_client = ResearchAssistant::OllamaInterface::ApiClient.new
  file_manager = ResearchAssistant::KnowledgeBase::FileManager.new(research_id)
  concept_extractor = ResearchAssistant::CoreEngine::ConceptExtractor.new
  question_engine = ResearchAssistant::CoreEngine::QuestionEngine.new(api_client: api_client)
  iteration_manager = ResearchAssistant::CoreEngine::IterationManager.new(
    api_client: api_client,
    file_manager: file_manager,
    question_engine: question_engine
  )

  # Run research
  analysis = concept_extractor.extract(topic)
  file_manager.save_analysis(analysis)

  iteration_manager.run(analysis)
end

main if __FILE__ == $0