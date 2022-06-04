# frozen_string_literal: true

require 'allure-rspec'
require 'bundler/setup'
require 'matic'
require 'client-api'
require 'json'
require 'validation_methods'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  ClientApi.configure do |c|
    c.base_url = 'https://pet-aggregator.matic.com'
    c.logger = { 'Dirname' => './logs', 'Filename' => 'test', 'StoreFilesCount' => 2 }

    c.before do |scenario|
      ClientApi::Request.new(scenario)
    end

    AllureRspec.configure do |config|
      config.results_directory = "report/allure-results"
      config.logging_level = Logger::INFO
      config.logger = Logger.new($stdout, Logger::DEBUG)
    end
  end
end
