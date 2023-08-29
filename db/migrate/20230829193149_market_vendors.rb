class MarketVendors < ActiveRecord::Migration[7.0]
  def change
    create_table :market_vendors do |t|
      t.integer :market_id
      t.integer :vendor_id
    end
  end
end
