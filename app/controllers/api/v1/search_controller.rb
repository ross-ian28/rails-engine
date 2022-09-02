class Api::V1::SearchController < ApplicationController
  def show
    merchant = Merchant.find_merchant(params[:name])
    if merchant != nil
      render json: MerchantSerializer.format_merchant(merchant)
    else
      render json: {
        data: {}
        }
    end
  end

  def index
    items = Item.find_items(params[:name])
    render json: ItemSerializer.format_items(items)
  end
end
