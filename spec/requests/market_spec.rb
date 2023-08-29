require 'rails_helper'
require 'json'

RSpec.describe 'API V0 Markets', type: :request do
  describe 'GET /api/v0/markets' do
    it 'returns a list of all markets' do
      # Perform the request
      
      m1 = create(:market)
      5.times do
        FactoryBot.create(:market)
      end
      v1 = create(:vendor)

      mv1 = create(:market_vendor, market: m1, vendor: v1)

      get '/api/v0/markets'
      
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
end