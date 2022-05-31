# frozen_string_literal: true

RSpec.describe 'API Requests testsuite' do
  before(:each) do
    @api = ClientApi::Api.new
    cat_id
    dog_id
    nil_id
  end

  after(:each) do
    puts @api.body
  end

  it 'valid POST request' do
    value = %w[cat dog].sample
    @api.post('/pet_requests', { "kind": value })
    expect(@api.status).to eq(201)
    expect(@api.body['kind']).to eql value
  end

  it 'GET cats' do
    @api.get("/pet_requests/#{@cat_id}/offers", nil)
    expect(@api.status).to eq(200)
  end

  it 'GET cats with sorted price and asc direction' do
    @api.get(
      {
        url: "/pet_requests/#{@cat_id}/offers?",
        query: {
          'sort_by': 'price',
          'direction': 'asc'
        }
      }
    )
    expect(asc_validation(@api)).to be(true)
  end

  it 'GET cats with sorted price and desc direction' do
    @api.get(
      {
        url: "/pet_requests/#{@dog_id}/offers?",
        query: {
          'sort_by': 'price',
          'direction': 'desc'
        }
      }
    )
    expect(desc_validation(@api)).to be(true)
  end

  it 'GET dogs' do
    @api.get("/pet_requests/#{@dog_id}/offers", nil)
    expect(@api.status).to eq(200)
  end

  it 'GET dogs with sorted price and asc direction' do
    @api.get(
      {
        url: "/pet_requests/#{@dog_id}/offers?",
        query: {
          'sort_by': 'price',
          'direction': 'asc'
        }
      }
    )
    expect(asc_validation(@api)).to be(true)
  end

  it 'GET dogs with sorted price and desc direction' do
    @api.get(
      {
        url: "/pet_requests/#{@dog_id}/offers?",
        query: {
          'sort_by': 'price',
          'direction': 'desc'
        }
      }
    )
    expect(desc_validation(@api)).to be(true)
  end

  it 'GET all' do
    @api.get("/pet_requests/#{@nil_id}/offers", nil)
    expect(@api.status).to eq(200)
  end

  it 'GET all with sorted price and asc direction' do
    @api.get(
      {
        url: "/pet_requests/#{@nil_id}/offers?",
        query: {
          'sort_by': 'price',
          'direction': 'asc'
        }
      }
    )
    expect(asc_validation(@api)).to be(true)
  end

  it 'GET all with sorted price and desc direction' do
    @api.get(
      {
        url: "/pet_requests/#{@nil_id}/offers?",
        query: {
          'sort_by': 'price',
          'direction': 'desc'
        }
      }
    )
    expect(desc_validation(@api)).to be(true)
  end

  it 'GET cats with price lesser than N' do
    @api.get(
      {
        url: "/pet_requests/#{@cat_id}/offers?",
        query: {
          'price_lt': '200'
        }
      }
    )
    expect(price_lt_validation(@api, 200.to_s)).to be(true)
    puts 'Warning! Your array is empty' if prices_response(@api).empty?
  end

  it 'GET dogs with price lesser than N' do
    @api.get(
      {
        url: "/pet_requests/#{@dog_id}/offers?",
        query: {
          'price_lt': '200'
        }
      }
    )
    expect(price_lt_validation(@api, 200.to_s)).to be(true)
    puts 'Warning! Your array is empty' if prices_response(@api).empty?
  end

  it 'GET all with price lesser than N' do
    @api.get(
      {
        url: "/pet_requests/#{@nil_id}/offers?",
        query: {
          'price_lt': '200'
        }
      }
    )
    expect(price_lt_validation(@api, 200.to_s)).to be(true)
    puts 'Warning! Your array is empty' if prices_response(@api).empty?
  end

  it 'GET cats with price greater than N' do
    @api.get(
      {
        url: "/pet_requests/#{@cat_id}/offers?",
        query: {
          'price_gt': '200'
        }
      }
    )
    expect(price_gt_validation(@api, 200.to_s)).to be(true)
    puts 'Warning! Your array is empty' if prices_response(@api).empty?
  end


  it 'GET dogs with price greater than N' do
    @api.get(
      {
        url: "/pet_requests/#{@dog_id}/offers?",
        query: {
          'price_gt': '200'
        }
      }
    )
    expect(price_gt_validation(@api, 200.to_s)).to be(true)
    puts 'Warning! Your array is empty' if prices_response(@api).empty?
  end

  it 'GET all with price greater than N' do
    @api.get(
      {
        url: "/pet_requests/#{@nil_id}/offers?",
        query: {
          'price_gt': '200'
        }
      }
    )
    expect(price_gt_validation(@api, 200.to_s)).to be(true)
    puts 'Warning! Your array is empty' if prices_response(@api).empty?
  end
end
