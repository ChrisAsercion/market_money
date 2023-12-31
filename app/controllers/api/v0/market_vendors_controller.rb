class Api::V0::MarketVendorsController < ApplicationController

  def create
    market_vendor = MarketVendor.new(market_vendors_params)
    if market_vendor.save 
      render json: MarketVendorSerializer.new(market_vendor), status: :created
    else 
      render json: { errors: market_vendor.errors.full_messages }, status: 404
    end
  end

  def destroy
    market_vendor = MarketVendor.find_by(market_id: params[:market_id], vendor_id: params[:vendor_id])
    if market_vendor
      market_vendor.destroy
      head :no_content
    else
      render json: { errors: ['MarketVendor not found'] }, status: :not_found
    end
  end

  private 

  def market_vendors_params
    params.permit(:vendor_id, :market_id)
  end
end