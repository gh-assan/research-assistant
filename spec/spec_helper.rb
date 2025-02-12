require 'webmock/rspec'
require 'factory_bot'
require 'faker'
require 'rspec'
require_relative '../lib/research_assistant'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  # config.example_status_persistence_file_path = ".rspec_status"
  #
  # # Disable RSpec exposing methods globally on `Module` and `main`
  # config.disable_monkey_patching!
  #
  # # Include FactoryBot methods
  # config.include FactoryBot::Syntax::Methods
  #
  # # Configure WebMock
  # WebMock.disable_net_connect!(allow_localhost: true)

  # Run tests in random order
  config.order = :random
end