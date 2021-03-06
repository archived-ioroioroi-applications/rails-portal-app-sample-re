# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180113062507) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.datetime "date", null: false
    t.string "category"
    t.string "link", null: false
    t.string "title", null: false
    t.string "icon"
    t.string "source_link", null: false
    t.string "source_title", null: false
    t.string "source_icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["link"], name: "index_articles_on_link", unique: true
  end

end
