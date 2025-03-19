require 'spec_helper'

RSpec.describe ResearchAssistant::StoryAgent::GenericCommand do
  describe 'MODEL constant' do
    it 'has the correct model name' do
      expect(described_class::MODEL).to eq('research-assistant-stories-generic-command-model')
    end
  end

  describe 'inheritance' do
    it 'inherits from BaseCommand' do
      expect(described_class.superclass).to eq(ResearchAssistant::StoryAgent::BaseCommand)
    end
  end
end