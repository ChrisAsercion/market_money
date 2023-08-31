require 'rails_helper'
require 'json'

RSpec.describe 'API V0 MarketVendors', type: :request do
  #US8
  describe 'POST /api/v0/market_vendors' do
    it 'should create a new association between a market and a vendor' do
      v1 = create(:vendor)
  
      m1 = create(:market)

      post api_v0_market_vendors_path(market_id: m1.id), params: { vendor_id: v1.id }

      json_response = JSON.parse(response.body)
      
      expect(json_response["data"]["attributes"]["market_id"]).to eq(m1.id)
      expect(json_response["data"]["attributes"]["vendor_id"]).to eq(v1.id)

    end

    it 'should display a flash message ' do
      #Both the market_id and the vendor_id don't exist for anything which should flag both errors back
      post api_v0_market_vendors_path(market_id: 987654321), params: { vendor_id: 54861 }

      json_response = JSON.parse(response.body)
      
      expect(json_response["errors"][0]).to eq("Market must exist")
      expect(json_response["errors"][1]).to eq("Vendor must exist")
    end
  end

end