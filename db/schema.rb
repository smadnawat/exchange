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

ActiveRecord::Schema.define(version: 20150602123910) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "banners", force: :cascade do |t|
    t.string   "banner_name"
    t.string   "author_name"
    t.string   "link"
    t.string   "image"
    t.integer  "clicks",      default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "books", force: :cascade do |t|
    t.string   "title",                       null: false
    t.string   "author",                      null: false
    t.string   "genre",                       null: false
    t.date     "upload_date",                 null: false
    t.string   "isbn_code",                   null: false
    t.string   "upload_type",                 null: false
    t.string   "latitude",    default: "0.0", null: false
    t.string   "longitude",   default: "0.0", null: false
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "devices", force: :cascade do |t|
    t.string   "device_id"
    t.string   "device_type"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.string   "subject"
    t.text     "content"
    t.string   "location"
    t.string   "author"
    t.string   "genre"
    t.string   "all"
    t.string   "sub_locations", default: [],              array: true
    t.string   "sub_authors",   default: [],              array: true
    t.string   "sub_genres",    default: [],              array: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "reading_preferences", force: :cascade do |t|
    t.string   "title",      null: false
    t.string   "author",     null: false
    t.string   "genre",      null: false
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reading_preferences", ["user_id"], name: "index_reading_preferences_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "gender"
    t.string   "email"
    t.string   "password_digest"
    t.string   "author_prefernce"
    t.string   "genre_preference"
    t.string   "location"
    t.date     "date_signup"
    t.string   "picture"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.float    "latitude",         default: 0.0,   null: false
    t.float    "longitude",        default: 0.0,   null: false
    t.string   "provider",         default: "",    null: false
    t.string   "u_id",             default: "",    null: false
    t.boolean  "is_block",         default: false
  end

  add_foreign_key "devices", "users"
  add_foreign_key "reading_preferences", "users"
end
