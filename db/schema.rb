# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_29_193149) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "market_vendors", force: :cascade do |t|
    t.integer "market_id"
    t.integer "vendor_id"
  end

  create_table "markets", force: :cascade do |t|
    t.string "name"
    t.string "street"
    t.string "city"
    t.string "county"
    t.string "state"
    t.string "zip"
    t.string "lat"
    t.string "lon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "contact_name"
    t.string "contact_phone"
    t.boolean "credit_accepted"
  end

end
