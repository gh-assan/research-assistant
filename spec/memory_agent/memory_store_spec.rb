require 'spec_helper'
require 'fileutils'
require 'tmpdir'
require 'securerandom'

RSpec.describe ResearchAssistant::MemoryAgent::MemoryStore do
  let(:memory_file) { File.join(Dir.tmpdir, "test_memory_#{SecureRandom.hex(8)}.json") }
  let(:memory_store) { described_class.new(memory_file) }

  after do
    FileUtils.rm_f(memory_file)
  end

  describe "#initialize" do
    it "creates a memory.json file with an empty hash if it doesn't exist" do
      memory_store
      expect(File.exist?(memory_file)).to be true
      expect(JSON.parse(File.read(memory_file))).to eq({})
    end

    it "does not overwrite an existing memory file" do
      initial_content = { "existing_key" => "existing_value" }
      File.write(memory_file, JSON.pretty_generate(initial_content))
      memory_store
      expect(JSON.parse(File.read(memory_file))).to eq(initial_content)
    end
  end

  describe "#read" do
    it "returns the content of the memory file" do
      File.write(memory_file, JSON.pretty_generate({ "key" => "value" }))
      expect(memory_store.read).to eq({ "key" => "value" })
    end

    it "returns an empty hash if the file does not exist" do
      FileUtils.rm_f(memory_file) # Ensure file is removed before test
      expect(memory_store.read).to eq({})
    end

    it "returns an empty hash if the file content is invalid JSON" do
      File.write(memory_file, "invalid json")
      expect(memory_store.read).to eq({})
    end
  end

  describe "#write" do
    it "writes the given data to the memory file" do
      memory_store.write({ "new_key" => "new_value" })
      expect(JSON.parse(File.read(memory_file))).to eq({ "new_key" => "new_value" })
    end

    it "overwrites existing content in the memory file" do
      File.write(memory_file, JSON.pretty_generate({ "old_key" => "old_value" }))
      memory_store.write({ "new_key" => "new_value" })
      expect(JSON.parse(File.read(memory_file))).to eq({ "new_key" => "new_value" })
    end
  end
end
