require 'rails_helper'

RSpec.describe 'The search API endpoints' do
  describe 'happy path find one merchant' do
    before :each do
      @merchant1 = Merchant.create(name: "Pabu")
      @merchant2 = Merchant.create(name: "Loki")
      @merchant2 = Merchant.create(name: "Thor")
    end
    it 'sends a single merchant by keyword' do
      get '/api/v1/merchants/find?name=Pabu'

      response_body = JSON.parse(response.body, symbolize_names: true)
      merchant = response_body[:data]

      expect(response).to be_successful

      expect(merchant[:id]).to eq(@merchant1.id.to_s)
      expect(merchant[:attributes][:name]).to eq(@merchant1.name)
    end
  end

  describe 'happy path find all items' do
    before :each do
      merchant = create(:merchant)
      @item1 = Item.create(name: "Shiny Ring", description: "For your finger", unit_price: 200, merchant_id: merchant.id)
      @item2 = Item.create(name: "Square Ring", description: "For your finger", unit_price: 20, merchant_id: merchant.id)
      @item3 = Item.create(name: "Shiny Necklace", description: "For your neck", unit_price: 140, merchant_id: merchant.id)
    end
    it 'sends every item by keyword' do
      get '/api/v1/items/find_all?name=ring'
      response_body = JSON.parse(response.body, symbolize_names: true)
      items = response_body[:data]

      expect(items.count).to eq(2)
      items.each do |item|
        expect(item[:attributes][:name]).to_not eq(@item3.name)
      end
    end
    # xit 'sends every item by min price' do
    #   get '/api/v1/items/find_all?min_price=50'
    # end
    # xit 'sends every item by max price' do
    #   get '/api/v1/items/find_all?max_price=100'
    # end
    # xit 'sends every item by min and max price' do
    #   get '/api/v1/items/find_all?min_price=50&max_price=200'
    # end
  end

  describe 'sad path find one merchant' do
    before :each do
      @merchant1 = Merchant.create(name: "Pabu")
      @merchant2 = Merchant.create(name: "Loki")
      @merchant2 = Merchant.create(name: "Thor")
    end
    it 'returns 404 if no match found' do
      get '/api/v1/merchants/find?name=Apollo'

      response_body = JSON.parse(response.body, symbolize_names: true)
      merchant = response_body[:data]

      expect(merchant).to eq([])
    end
    # xit 'parameter cant be missing' do
    #   get 'api/v1/merchants/find'
    # end
  end

  describe 'sad path find all items' do
    # xit 'cant send both name and min price' do
    #   get '/api/v1/items/find_all?name=ring&min_price=10'
    # end
    # xit 'cant send both name and max price' do
    #   get '/api/v1/items/find_all?name=ring&max_price=10'
    # end
    # xit 'cant send name, max, and min price' do
    #   get '/api/v1/items/find_all?name=ring&min_price=10&max_price=100'
    # end
  end
end
