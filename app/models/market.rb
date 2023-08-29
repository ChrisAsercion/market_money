class Market < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :county
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :lat
  validates_presence_of :lon
end