# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'research_assistant/version'

Gem::Specification.new do |spec|
  spec.name          = 'research-assistant'
  spec.version       = ResearchAssistant::VERSION
  spec.authors       = ['gh-assan']
  spec.summary       = %w(research-assistant)
  spec.description   = %w(research-assistant)
  spec.license       = 'MIT'
end
