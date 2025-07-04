require 'spec_helper'
require 'time'
require_relative '../../lib/research_assistant/memory_agent/memory_prioritizer'
require_relative '../../lib/research_assistant/memory_agent/memory_manager'

RSpec.describe ResearchAssistant::MemoryAgent::MemoryPrioritizer do
  let(:memory_manager) { instance_double(ResearchAssistant::MemoryAgent::MemoryManager) }
  let(:prioritizer) { described_class.new(memory_manager) }

  describe '#prioritize_memories' do
    it 'prioritizes memories based on relevance, importance, and recency' do
      memories = {
        'key1' => { 'value' => 'AI impact on jobs', 'importance' => 5, 'last_accessed' => Time.now.to_i - 100 },
        'key2' => { 'value' => 'Unrelated topic', 'importance' => 2, 'last_accessed' => Time.now.to_i - 200 },
        'key3' => { 'value' => 'AI job creation', 'importance' => 8, 'last_accessed' => Time.now.to_i - 50 }
      }

      allow(memory_manager).to receive(:read).and_return(memories)

      prioritized = prioritizer.prioritize_memories('AI')

      expect(prioritized.first[:key]).to eq('key3')
      expect(prioritized.last[:key]).to eq('key2')
    end
  end
end
