class Api::V0::MarketsController < ApplicationController

  def index
    markets = Market.all
    render json: MarketSerializer.new(markets)
  end

  def show
    begin
      render json: MarketSerializer.new(Market.find(params[:id]))
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
