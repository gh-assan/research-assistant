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

    attr_accessor :ollama_url, :max_iterations, :log_level, :research_dir, :ollama_model, :json_model, :writer_model

    def initialize
      @ollama_url = ENV.fetch('OLLAMA_URL', 'http://localhost:11434')
      @max_iterations = ENV.fetch('MAX_ITERATIONS', 5).to_i
      @log_level = ENV.fetch('LOG_LEVEL', 'info')
      @research_dir = ENV.fetch('RESEARCH_DIR', 'research')
      @ollama_model = ENV.fetch('OLLAMA_MODEL', 'research-assistant-reasoning-model')
      @json_model = ENV.fetch('OLLAMA_MODEL', 'research-assistant-json-model')
      @writer_model = ENV.fetch('OLLAMA_MODEL', 'research-assistant-writer-model')
    end
  end

  def self.config
    Configuration.instance
  end
end