class Api::V0::MarketsController < ApplicationController

  def index
    #require 'pry'; binding.pry
    markets = Market.all
    render json: MarketSerializer.new(markets)
  end
end
