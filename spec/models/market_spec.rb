require 'rails_helper'
# require 'json'

RSpec.describe Market, type: :model do

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :street}
    it {should validate_presence_of :city}
    it {should validate_presence_of :county}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :lat}
    it {should validate_presence_of :lon}
  end

  describe 'relationships' do
    it {should have_many :market_vendors}
    it {should have_many(:vendors).through(:market_vendors)}
  end

  # describe 'GET /api/v0/markets' do
  #   it 'returns a list of all markets' do
  #     # Perform the request
  #     get '/api/v0/markets'
      
  #     # Expect a successful response
  #     expect(response).to have_http_status(200)
      
  #     # Parse JSON response
  #     json_response = JSON.parse(response.body)
      
  #     # Expect 'data' key to be present
  #     expect(json_response).to have_key('data')
      
  #     # Expect the 'data' value to be an array
  #     expect(json_response['data']).to be_an(Array)
      
  #     # You can add more specific expectations here if needed
  #     # For example, checking attributes of the first market
  #     first_market = json_response['data'][0]
  #     expect(first_market).to have_key('id')
  #     expect(first_market).to have_key('type')
  #     expect(first_market).to have_key('attributes')
  #   end
  # end
end
