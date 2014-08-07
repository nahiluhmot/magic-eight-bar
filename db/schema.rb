# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140807005141) do

  create_table "bars", force: true do |t|
    t.string   "name",       limit: 120,                          null: false
    t.string   "place_id",   limit: 40,                           null: false
    t.string   "address",    limit: 120,                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "lat",                    precision: 11, scale: 8
    t.decimal  "lon",                    precision: 11, scale: 8
  end

  add_index "bars", ["place_id"], name: "index_bars_on_place_id", unique: true, using: :btree

  create_table "reviews", force: true do |t|
    t.integer  "user_id"
    t.integer  "bar_id"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["bar_id"], name: "index_reviews_on_bar_id", using: :btree
  add_index "reviews", ["user_id", "bar_id"], name: "index_reviews_on_user_id_and_bar_id", unique: true, using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "session",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["session"], name: "index_users_on_session", unique: true, using: :btree

end
