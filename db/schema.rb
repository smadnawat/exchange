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

ActiveRecord::Schema.define(version: 20150619070728) do

  create_table "books", force: :cascade do |t|
    t.string   "title",       limit: 255,               null: false
    t.string   "author",      limit: 255,               null: false
    t.string   "genre",       limit: 255,               null: false
    t.string   "upload_type", limit: 255,               null: false
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.float    "latitude",    limit: 24,  default: 0.0, null: false
    t.float    "longitude",   limit: 24,  default: 0.0, null: false
    t.string   "address",     limit: 255, default: "",  null: false
    t.integer  "upload_date", limit: 4
  end

  create_table "devices", force: :cascade do |t|
    t.string   "device_id",   limit: 255
    t.string   "device_type", limit: 255
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "reading_preferences", force: :cascade do |t|
    t.string   "title",              limit: 255,                 null: false
    t.string   "author",             limit: 255,                 null: false
    t.string   "genre",              limit: 255,                 null: false
    t.integer  "user_id",            limit: 4
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.boolean  "book_deactivated",   limit: 1,   default: false
    t.boolean  "author_deactivated", limit: 1,   default: false
    t.boolean  "genre_deactivated",  limit: 1,   default: false
  end

  add_index "reading_preferences", ["user_id"], name: "index_reading_preferences_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",               limit: 255
    t.string   "gender",                 limit: 255
    t.string   "email",                  limit: 255
    t.string   "password_digest",        limit: 255
    t.string   "author_prefernce",       limit: 255
    t.string   "genre_preference",       limit: 255
    t.string   "location",               limit: 255
    t.date     "date_signup"
    t.string   "picture",                limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.float    "latitude",               limit: 24,    default: 0.0, null: false
    t.float    "longitude",              limit: 24,    default: 0.0, null: false
    t.string   "provider",               limit: 255,   default: "",  null: false
    t.string   "u_id",                   limit: 255,   default: "",  null: false
    t.string   "device_used",            limit: 255
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.string   "address",                limit: 255,   default: "",  null: false
    t.text     "about_me",               limit: 65535
  end

  add_foreign_key "devices", "users"
  add_foreign_key "reading_preferences", "users"
end
