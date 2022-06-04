# frozen_string_literal: true

RSpec.describe 'API Requests testsuite' do
  let(:cat) do
    @api = ClientApi::Api.new
    @api.post('/pet_requests', { "kind": 'cat' })
    @api.body['id']
  end

  let(:dog) do
    @api = ClientApi::Api.new
    @api.post('/pet_requests', { "kind": 'dog' })
    @api.body['id']
  end

  let(:all) do
    @api = ClientApi::Api.new
    @api.post('/pet_requests', { "kind": nil })
    @api.body['id']
  end

  let(:warning_message) { 'Test failed because of wrong direction' }

  before do
    @new_api = ClientApi::Api.new
  end

  after do
    puts @new_api.body
  end

  it 'valid POST request' do
    value = %w[cat dog].sample
    @new_api.post('/pet_requests', { "kind": value })
    expect(@new_api.status).to eq(201)
    expect(@new_api.body['kind']).to eql value
  end

  it 'GET cats' do
    @new_api.get("/pet_requests/#{cat}/offers", nil)
    expect(@new_api.status).to eq(200)
  end

  it 'GET cats with sorted price and asc direction' do
    @new_api.get(
      {
        url: "/pet_requests/#{cat}/offers?",
        query: {
          'sort_by': 'price',
          'direction': 'asc'
        }
      }
    )
    expect(asc_validation(@new_api)).to be(true), warning_message
  end

  it 'GET cats with sorted price and desc direction' do
    @new_api.get(
      {
        url: "/pet_requests/#{cat}/offers?",
        query: {
          'sort_by': 'price',
          'direction': 'desc'
        }
      }
    )
    expect(desc_validation(@new_api)).to be(true), warning_message
  end

  it 'GET dogs' do
    @new_api.get("/pet_requests/#{dog}/offers", nil)
    expect(@new_api.status).to eq(200)
  end

  it 'GET dogs with sorted price and asc direction' do
    @new_api.get(
      {
        url: "/pet_requests/#{dog}/offers?",
        query: {
          'sort_by': 'price',
          'direction': 'asc'
        }
      }
    )
    expect(asc_validation(@new_api)).to be(true), warning_message
  end

  it 'GET dogs with sorted price and desc direction' do
    @new_api.get(
      {
        url: "/pet_requests/#{dog}/offers?",
        query: {
          'sort_by': 'price',
          'direction': 'desc'
        }
      }
    )
    expect(desc_validation(@new_api)).to be(true), warning_message
  end

  it 'GET all' do
    @new_api.get("/pet_requests/#{all}/offers", nil)
    expect(@new_api.status).to eq(200)
  end

  it 'GET all with sorted price and asc direction' do
    @new_api.get(
      {
        url: "/pet_requests/#{all}/offers?",
        query: {
          'sort_by': 'price',
          'direction': 'asc'
        }
      }
    )
    expect(asc_validation(@new_api)).to be(true), warning_message
  end

  it 'GET all with sorted price and desc direction' do
    @new_api.get(
      {
        url: "/pet_requests/#{all}/offers?",
        query: {
          'sort_by': 'price',
          'direction': 'desc'
        }
      }
    )
    expect(desc_validation(@new_api)).to be(true), warning_message
  end

  it 'GET cats with price lesser than N' do
    @new_api.get(
      {
        url: "/pet_requests/#{cat}/offers?",
        query: {
          'price_lt': '200'
        }
      }
    )
    expect(price_lt_validation(@new_api, 200.to_s)).to be(true)
    puts 'Warning! Your array is empty' if prices_response(@new_api).empty?
  end

  it 'GET dogs with price lesser than N' do
    @new_api.get(
      {
        url: "/pet_requests/#{dog}/offers?",
        query: {
          'price_lt': '200'
        }
      }
    )
    expect(price_lt_validation(@new_api, 200.to_s)).to be(true)
    puts 'Warning! Your array is empty' if prices_response(@new_api).empty?
  end

  it 'GET all with price lesser than N' do
    @new_api.get(
      {
        url: "/pet_requests/#{all}/offers?",
        query: {
          'price_lt': '200'
        }
      }
    )
    expect(price_lt_validation(@new_api, 200.to_s)).to be(true)
    puts 'Warning! Your array is empty' if prices_response(@new_api).empty?
  end

  it 'GET cats with price greater than N' do
    @new_api.get(
      {
        url: "/pet_requests/#{cat}/offers?",
        query: {
          'price_gt': '200'
        }
      }
    )
    expect(price_gt_validation(@new_api, 200.to_s)).to be(true)
    puts 'Warning! Your array is empty' if prices_response(@new_api).empty?
  end

  it 'GET dogs with price greater than N' do
    @new_api.get(
      {
        url: "/pet_requests/#{dog}/offers?",
        query: {
          'price_gt': '200'
        }
      }
    )
    expect(price_gt_validation(@new_api, 200.to_s)).to be(true)
    puts 'Warning! Your array is empty' if prices_response(@new_api).empty?
  end

  it 'GET all with price greater than N' do
    @new_api.get(
      {
        url: "/pet_requests/#{all}/offers?",
        query: {
          'price_gt': '200'
        }
      }
    )
    expect(price_gt_validation(@new_api, 200.to_s)).to be(true)
    puts 'Warning! Your array is empty' if prices_response(@new_api).empty?
  end
end
