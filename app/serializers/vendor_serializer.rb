class VendorSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :contact_name, :contact_phone, :credit_accepted#, :states_sold_in

  has_many :markets

  def states_sold_in
    require 'pry'; binding.pry
  end
end
