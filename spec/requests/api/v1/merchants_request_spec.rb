require 'rails_helper'

RSpec.describe 'The merchants API endpoints' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    response_body = JSON.parse(response.body, symbolize_names: true)

    merchants = response_body[:data]

    expect(response).to be_successful
    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(Integer)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end
  it 'sends a single merchant' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

     get "/api/v1/merchants/#{merchant1.id}"

    response_body = JSON.parse(response.body, symbolize_names: true)

    merchant = response_body[:data]

    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(String)
    expect(merchant[:id]).to eq(merchant1.id.to_s)
    expect(merchant[:id]).to_not eq(merchant2.id.to_s)

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes][:name]).to be_a(String)
  end
  it 'sends all items belonging to a merchant' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    create_list(:item, 3, merchant_id: merchant1.id)
    item2 = create(:item, merchant_id: merchant2.id)

    get "/api/v1/merchants/#{merchant1.id}/items"

    response_body = JSON.parse(response.body, symbolize_names: true)

    merchant = response_body[:data]

    expect(response).to be_successful

    expect(merchant.count).to eq(3)

    merchant.each do |item|
      expect(item).to have_key(:id)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:id]).to_not eq(item2[:id])
    end
  end
end
