class Api::V0::MarketsController < ApplicationController

  def index
    require 'pry'; binding.pry
    render json: Market.all
  end
end
