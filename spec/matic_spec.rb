# frozen_string_literal: true

RSpec.describe 'API Requests testsuite' do
  before(:each) do
    @api = ClientApi::Api.new
    cat_id
    dog_id
    nil_id
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
    puts @api.body
  end

  it 'GET cats with sorted price' do
    @api.get(
      {
        url: "/pet_requests/#{@cat_id}/offers?",
        query: {
          'sort_by': 'price'
        }
      }
    )
    expect(@api.status).to eq(200)


  end

  it 'GET dogs' do
    @api.get("/pet_requests/#{@dog_id}/offers", nil)
    expect(@api.status).to eq(200)
    puts @api.body
  end

  it 'GET all' do
    @api.get("/pet_requests/#{@nil_id}/offers", nil)
    expect(@api.status).to eq(200)
    puts @api.body
  end
end
