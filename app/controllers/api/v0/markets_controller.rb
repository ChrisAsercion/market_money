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

  def search
    if valid_search_params?
      markets = Market.search_by_params(search_params)
      
      render json: markets, status: :ok
    else
      render json: { errors: 'Invalid parameters' }, status: :unprocessable_entity
    end
  end

  private

  def valid_search_params?
    # Check if the combination of parameters is valid
    # For example:
    #  - Only allow state, city, and name to be present together
    (params[:state].present? && params[:city].present? && params[:name].present?) ||
      (params[:state].present? && params[:name].present?) ||
      (params[:name].present?)
  end

  def search_params
    params.permit(:state, :city, :name)
  end


end
