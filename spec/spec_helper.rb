# frozen_string_literal: true

require 'bundler/setup'
require 'matic'
require 'client-api'
require 'json'

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

    c.before(:each) do |scenario|
      ClientApi::Request.new(scenario)
    end
  end

  def api_init
    @api = ClientApi::Api.new
  end

  def cat_id
    api_init
    @api.post('/pet_requests', { "kind": 'cat' })
    @cat_id = @api.body['id']
  end

  def dog_id
    api_init
    @api.post('/pet_requests', { "kind": 'dog' })
    @dog_id = @api.body['id']
  end

  def nil_id
    api_init
    @api.post('/pet_requests', { "kind": nil })
    @nil_id = @api.body['id']
  end

  def asc_validation(response)
    prices_array = response.body.flat_map { |response| response['price'] }
    prices_array[0] < prices_array[1]
  end

  def prices_response(response)
    @prices_array = response.body.flat_map { |response| response['price'] }
  end

  def desc_validation(response)
    prices_array = response.body.flat_map { |response| response['price'] }
    prices_array[0] > prices_array[1]
  end

  def price_lt_validation(response, num)
    prices_array = response.body.flat_map { |response| response['price'] }
    prices_array.all? { |elem| elem < num }
  end

  def price_gt_validation(response, num)
    prices_array = response.body.flat_map { |response| response['price'] }
    prices_array.all? { |elem| elem > num }
  end
end
