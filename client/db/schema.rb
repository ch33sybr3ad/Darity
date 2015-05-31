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

ActiveRecord::Schema.define(version: 20150530212302) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "charities", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.text     "description"
    t.string   "followers"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "dares", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "daree_id"
    t.integer  "proposer_id"
    t.integer  "charity_id"
    t.boolean  "done",        default: false
    t.float    "price"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "donations", force: :cascade do |t|
    t.integer  "pledger_id"
    t.integer  "pledged_dare_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "donation_amount"
    t.boolean  "completed",       default: false
  end

  create_table "generate_dares", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "pending_dares", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "daree_id"
    t.integer  "proposer_id"
    t.string   "twitter_handle"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.string   "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "videos", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "dare_id"
    t.text     "description"
    t.string   "uid"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
