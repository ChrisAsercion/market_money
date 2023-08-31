class Market < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :county
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :lat
  validates_presence_of :lon

  has_many :market_vendors
  has_many :vendors, through: :market_vendors

  def self.search_by_params(params)
    markets = self.all
    
    if params[:state].present?
      markets = markets.where(state: params[:state])
    end
    
    if params[:city].present?
      markets = markets.where(city: params[:city])
    end
    
    if params[:name].present?
      markets = markets.where(name: params[:name])
    end
    
    markets
  end
end