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

ActiveRecord::Schema.define(version: 20131213202358) do

  create_table "colors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matters", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matters_partypes", id: false, force: true do |t|
    t.integer "partype_id", null: false
    t.integer "matter_id",  null: false
  end

  add_index "matters_partypes", ["partype_id", "matter_id"], name: "index_matters_partypes_on_partype_id_and_matter_id"

  create_table "parts", force: true do |t|
    t.integer  "shoe_id"
    t.integer  "matter_id"
    t.integer  "partype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "parts", ["matter_id"], name: "index_parts_on_matter_id"
  add_index "parts", ["partype_id"], name: "index_parts_on_partype_id"
  add_index "parts", ["shoe_id"], name: "index_parts_on_shoe_id"

  create_table "partypes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shoes", force: true do |t|
    t.string   "name"
    t.float    "size"
    t.integer  "color_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shoes", ["color_id"], name: "index_shoes_on_color_id"

end
