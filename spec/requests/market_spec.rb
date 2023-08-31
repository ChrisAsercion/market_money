require 'rails_helper'
require 'json'

RSpec.describe 'API V0 Markets', type: :request do
  describe 'GET /api/v0/markets' do
    it 'returns a list of all markets' do
      # Perform the request
      
      m1 = create(:market)
      m2 = create(:market)
      m3 = create(:market)

      v1 = create(:vendor)
      v2 = create(:vendor)
      v3 = create(:vendor)

      mv1 = create(:market_vendor, market: m1, vendor: v1)
      mv2 = create(:market_vendor, market: m2, vendor: v2)
      mv3 = create(:market_vendor, market: m3, vendor: v3)



      #get '/api/v0/markets'

      get api_v0_markets_path
      
      # Expect a successful response
      expect(response).to have_http_status(200)
      
      # Parse JSON response
      json_response = JSON.parse(response.body)

      # Expect 'data' key to be present
      expect(json_response).to have_key('data')
      
      # Expect the 'data' value to be an array
      expect(json_response['data']).to be_an(Array)
      
      # You can add more specific expectations here if needed
      # For example, checking attributes of the first market
      first_market = json_response['data'][0]
      
      expect(first_market).to have_key('id')
      expect(first_market).to have_key('type')
      expect(first_market).to have_key('attributes')
      expect(first_market["id"]).to eq(m1["id"].to_s)
      expect(first_market["attributes"]["name"]).to eq(m1["name"])
    end
  end

  #US 2
  describe 'GET /api/v0/markets/:id' do
    it 'show display all market attributes as well as vendor count of a specific vendor' do
      m1 = create(:market)

      get api_v0_market_path(m1)

      expect(response).to have_http_status(200)

      json_response = JSON.parse(response.body)

      json_response["data"]

      expect(json_response["data"]["attributes"]["name"]).to eq(m1[:name])
      expect(json_response["data"]["id"]).to eq(m1[:id].to_s)

    end

    it 'displays a flash message if the id is not available' do
      m1 = create(:market)

      get api_v0_market_path("123123123123")

      json_response = JSON.parse(response.body)
      flash_message = json_response["errors"][0]["detail"]

      expect(flash_message).to eq("Couldn't find Market with 'id'=123123123123")
    end
  end

  #US 10
  describe 'GET /api/v0/markets/search' do
    it 'an accept city, state, and name parameters' do
      market1 = create(:market, state: 'California', city: 'Los Angeles', name: 'Market A')
      market2 = create(:market, state: 'California', city: 'San Francisco', name: 'Market B')

      get search_api_v0_markets_path params: { state: 'California', city: 'Los Angeles', name: 'Market A' }

      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      
      expect(json_response[0]['id']).to eq(market1.id)
      expect(json_response[0]['name']).to eq(market1.name)
    end

    context 'with invalid parameters' do
      it 'returns an error message and 422 status code for invalid parameter combination' do
        get search_api_v0_markets_path params: { state: 'California', city: 'Los Angeles' }

        json_response = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['errors']).to eq('Invalid parameters')
      end
    end
  end
end