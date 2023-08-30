class Api::V0::VendorsController < ApplicationController
  def index
    begin
      market = Market.find(params[:market_id])
      vendors = market.vendors
      render json: VendorSerializer.new(vendors)
    rescue ActiveRecord::RecordNotFound => error
      error_response = {
        "errors": [
            {
                "detail": error.message
            }
        ]
        }
    render json: error_response, status: :not_found
    end
  end
end