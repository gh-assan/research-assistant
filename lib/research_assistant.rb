# lib/research_assistant.rb
require 'zeitwerk'
require 'json'
require 'fileutils'
require 'faraday'
require 'dry-validation'
require 'smart_properties'
require 'async'

loader = Zeitwerk::Loader.for_gem
loader.setup

module ResearchAssistant
  class Configuration
    include Singleton

    attr_accessor :ollama_url, :max_iterations, :log_level, :research_dir

    def initialize
      @ollama_url = ENV.fetch('OLLAMA_URL', 'http://localhost:11434')
      @max_iterations = ENV.fetch('MAX_ITERATIONS', 10).to_i
      @log_level = ENV.fetch('LOG_LEVEL', 'info')
      @research_dir = ENV.fetch('RESEARCH_DIR', 'research')
    end
  end

  def self.config
    Configuration.instance
  end
end