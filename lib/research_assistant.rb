# lib/research_assistant.rb
require 'zeitwerk'
require 'json'
require 'fileutils'
require 'faraday'
require 'dry-validation'
require 'smart_properties'
require 'async'
require 'singleton'

loader = Zeitwerk::Loader.for_gem
loader.setup

module ResearchAssistant
  class Configuration
    include Singleton

    attr_accessor :ollama_url, :max_iterations, :log_level, :research_dir, :ollama_model, :json_model, :writer_model,
                  :brainstorming_model, :reviewer_model, :refiner_model, :max_agent_iterations, :agent_model,
                  :story_dir, :max_story_agent_iterations, :max_review_agent_iterations

    def initialize
      @ollama_url = ENV.fetch('OLLAMA_URL', 'http://localhost:11434')
      @max_iterations = ENV.fetch('MAX_ITERATIONS', 5).to_i
      @max_agent_iterations = ENV.fetch('MAX_AGENT_ITERATIONS', 10).to_i
      @max_story_agent_iterations = ENV.fetch('MAX_STORY_AGENT_ITERATIONS', 100).to_i
      @max_review_agent_iterations = ENV.fetch('MAX_REVIEW_AGENT_ITERATIONS', 10).to_i
      @log_level = ENV.fetch('LOG_LEVEL', 'info')
      @research_dir = ENV.fetch('RESEARCH_DIR', 'data/research')
      @ollama_model = ENV.fetch('OLLAMA_MODEL', 'research-assistant-reasoning-model')
      @json_model = ENV.fetch('OLLAMA_MODEL', 'research-assistant-json-model')
      @writer_model = ENV.fetch('OLLAMA_MODEL', 'research-assistant-writer-model')
      @brainstorming_model = ENV.fetch('BRAINSTORMING_MODEL', 'research-assistant-brainstorming-model')
      @reviewer_model = ENV.fetch('REVIEW_MODEL', 'research-assistant-reviewer-model')
      @refiner_model = ENV.fetch('REVIEW_MODEL', 'research-assistant-refiner-model')
      @agent_model = ENV.fetch('AGENT_MODEL', 'research-assistant-agent-model')

      @story_dir = ENV.fetch('STORY_DIR', 'data/story')
      @review_dir = ENV.fetch('REVIEW_DIR', 'data/review')
    end
  end

  def self.config
    Configuration.instance
  end
end