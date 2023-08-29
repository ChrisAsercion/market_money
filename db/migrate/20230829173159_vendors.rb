class Vendors < ActiveRecord::Migration[7.0]
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :description
      t.string :contact_name
      t.string :contact_phone
      t.boolean :credit_accepted

      
    end
  end
end
