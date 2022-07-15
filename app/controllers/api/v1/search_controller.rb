class Api::V1::SearchController < ApplicationController
  def show
    merchant = Merchant.find_merchant(params[:name])

    render json: MerchantSerializer.format_merchant(merchant)
  end

  def index
    # if params[:name] && (params[:min_price]! || params[:min_price]!)
    items = Item.find_items(params[:name])
    render json: ItemSerializer.format_items(items)
    # elsif params[:min_price]
    #
    # elsif params[:max_price]
    #
    # else
    #   render status: 404
    # end
  end
end
