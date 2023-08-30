require 'rails_helper'
require 'json'

RSpec.describe 'API V0 Market Vendors', type: :request do
  #US 3
  describe 'GET /api/v0/markets/:id/vendors' do
    it 'displays all of the vendors of a certain market' do
      m1 = create(:market)

      v1 = create(:vendor)
      v2 = create(:vendor)
      v3 = create(:vendor)

      mv1 = create(:market_vendor, market: m1, vendor: v1)
      mv2 = create(:market_vendor, market: m1, vendor: v2)

      get api_v0_market_vendors_path(m1)

      json_response = JSON.parse(response.body)
      
      v1_info = json_response['data'].first 
      v2_info = json_response['data'].second

      #checks to see that v1 & v2 information has been into the index
      expect(v1_info['id']).to eq(v1.id.to_s)
      expect(v1_info['attributes']['name']).to eq(v1.name)
      expect(v2_info['id']).to eq(v2.id.to_s)
      expect(v2_info['attributes']['description']).to eq(v2.description)

      #checks to see that only 2 vendors are on the list, v3 is not a vendor to m1
      expect(json_response['data'].count).to eq(2)
    end

    it 'displays a flash message if the id is not available' do
      m1 = create(:market)

      v1 = create(:vendor)
      
      mv1 = create(:market_vendor, market: m1, vendor: v1)

      get api_v0_market_vendors_path("123123123123")

      json_response = JSON.parse(response.body)
      flash_message = json_response["errors"][0]["detail"]
      
      expect(flash_message).to eq("Couldn't find Market with 'id'=123123123123")
    end
  end

  #US 4
  describe 'GET /api/v0/vendors/:id' do
    it 'sends a JSON object back with a top-level data key that points to the vendor resource with that id, and all attributes for that vendor.' do
      v1 = create(:vendor)

      get api_v0_vendor_path(v1)

      json_response = JSON.parse(response.body)

      expect(json_response["data"]["id"]).to eq(v1.id.to_s)
      expect(json_response["data"]["attributes"]["name"]).to eq(v1.name)

    end

    it 'sends a flash message back if the vendor id is not found in the data' do
      get api_v0_vendor_path("123123123123")

      json_response = JSON.parse(response.body)
      flash_message = json_response["errors"][0]["detail"]
      
      expect(flash_message).to eq("Couldn't find Vendor with 'id'=123123123123")
    end
  end
end