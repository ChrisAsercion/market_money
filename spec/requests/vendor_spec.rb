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

  #US5
  describe "POST /api/v0/vendors" do
    it "sends new information of a valid vendor to be added to the database" do
      
      new_vendor_info = attributes_for(:vendor)

      post api_v0_vendors_path, params:{ vendor: new_vendor_info }

      json_response = JSON.parse(response.body)

      vendors = Vendor.all
      newest_vendor = vendors.last

      #The results are the same as the attributes sent into the post by the test
      expect(json_response["data"]["attributes"]["name"]).to eq(new_vendor_info[:name])
      expect(json_response["data"]["attributes"]["contact_name"]).to eq(new_vendor_info[:contact_name])

      #Signifies the creation of a vendor
      expect(json_response["data"]["type"]).to eq("vendor")

      #Shows that the newest added vendor matches the information that was sent in as part of a vendor creation
      expect(newest_vendor.name).to eq(new_vendor_info[:name])
      expect(newest_vendor.description).to eq(new_vendor_info[:description])
    end 

    it "sends in incomplete information to the post and receives a flash notice back" do

        #name is missing in the params which should flag an error
      incomplete_data = {:description=>"Knowledge is pitiless.", :contact_name=>"Shirahoshi", :contact_phone=>"(275) 225-5321 x5234", :credit_accepted=>false}

      post api_v0_vendors_path, params:{ vendor: incomplete_data }

      json_response = JSON.parse(response.body)
      
      # #{attribute} can't be blank is the expected response
      expect(json_response["errors"][0]).to eq("Name can't be blank")
    end
  end

  #US 6
  describe 'PATCH /api/v0/vendors/:id' do
    it 'can pass any number and combination of attributes to be updated' do
      v1 = create(:vendor)
      
      #This updates the name of the vendor
      patch_data = {:name=> "A Brand New Update Company", :description=> v1.description, :contact_name=> v1.contact_name, :contact_phone=> v1.contact_phone, :credit_accepted=> v1.credit_accepted}

      patch api_v0_vendor_path(v1), params:{ vendor: patch_data}

      json_response = JSON.parse(response.body)
      
      expect(json_response["data"]["attributes"]["name"]).to eq("A Brand New Update Company")

    end

    it 'returns a flash message if the user cannot be found' do
      v1 = create(:vendor)
      
      #This sends an incomplete update to the update feature. It is testing for both nil and empty values with name and description
      incomplete_patch_data = {:name=> nil , :description=> "", :contact_name=> v1.contact_name, :contact_phone=> v1.contact_phone, :credit_accepted=> v1.credit_accepted}

      patch api_v0_vendor_path(v1), params:{ vendor: incomplete_patch_data}

      json_response = JSON.parse(response.body)
      
      expect(json_response["errors"][0]).to eq("Name can't be blank")

      expect(json_response["errors"][1]).to eq("Description can't be blank")
    end

    it 'returns a flash message if the user cannot be found' do
      patch_data = attributes_for(:vendor)

      patch api_v0_vendor_path("123123123123"), params:{ vendor: patch_data}

      json_response = JSON.parse(response.body)

      expect(json_response["errors"][0]["detail"]).to eq("Couldn't find Vendor with 'id'=123123123123")
    end
  end

  describe 'DELETE /api/v0/vendors/:id' do
    it 'When a valid id is passed in, that vendor will be destroyed, as well as any associations that vendor had' do
      v1 = create(:vendor)
  
      m1 = create(:market)

      mv1 = create(:market_vendor, market: m1, vendor: v1)

      delete api_v0_vendor_path(v1)

      expect(Vendor.all.count).to eq(0)
    end

    it 'returns a flash message if the user cannot be found' do
      patch_data = attributes_for(:vendor)

      delete api_v0_vendor_path("123123123123")

      json_response = JSON.parse(response.body)

      expect(json_response["errors"][0]["detail"]).to eq("Couldn't find Vendor with 'id'=123123123123")
    end
  end
end