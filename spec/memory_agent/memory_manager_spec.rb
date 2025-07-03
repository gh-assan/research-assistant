require 'spec_helper'

RSpec.describe ResearchAssistant::MemoryAgent::MemoryManager do
  let(:research_id) { "test_id" }
  let(:memory_manager) { described_class.new(research_id) }
  let(:memory_file) { File.join(ResearchAssistant.config.research_dir, research_id, 'memory.json') }

  before do
    FileUtils.mkdir_p(File.dirname(memory_file))
  end

  after do
    FileUtils.rm_f(memory_file)
  end

  describe "#initialize" do
    it "creates a memory.json file with an empty hash" do
      memory_manager
      expect(File.exist?(memory_file)).to be true
      expect(JSON.parse(File.read(memory_file))).to eq({})
    end
  end

  describe "#read" do
    it "returns the content of the memory file" do
      File.write(memory_file, JSON.pretty_generate({ "key" => "value" }))
      expect(memory_manager.read).to eq({ "key" => "value" })
    end
  end

  describe "#write" do
    it "writes the given data to the memory file" do
      memory_manager.write({ "new_key" => "new_value" })
      expect(JSON.parse(File.read(memory_file))).to eq({ "new_key" => "new_value" })
    end
  end
end
