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

ActiveRecord::Schema.define(version: 20150616111456) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string   "title",                     null: false
    t.string   "author",                    null: false
    t.string   "genre",                     null: false
    t.date     "upload_date",               null: false
    t.string   "upload_type",               null: false
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.float    "latitude",    default: 0.0, null: false
    t.float    "longitude",   default: 0.0, null: false
    t.string   "address",     default: "",  null: false
  end

  create_table "devices", force: :cascade do |t|
    t.string   "device_id"
    t.string   "device_type"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "invitations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.string   "invitation_type"
    t.integer  "attendee"
    t.string   "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "invitations", ["book_id"], name: "index_invitations_on_book_id", using: :btree
  add_index "invitations", ["user_id"], name: "index_invitations_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.string   "action_type"
    t.integer  "reciever_id"
    t.boolean  "pending"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "invitation_id"
  end

  add_index "notifications", ["book_id"], name: "index_notifications_on_book_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

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
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.float    "latitude",               default: 0.0, null: false
    t.float    "longitude",              default: 0.0, null: false
    t.string   "provider",               default: "",  null: false
    t.string   "u_id",                   default: "",  null: false
    t.string   "device_used"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
  end

  add_foreign_key "devices", "users"
  add_foreign_key "invitations", "books"
  add_foreign_key "invitations", "users"
  add_foreign_key "notifications", "books"
  add_foreign_key "notifications", "users"
  add_foreign_key "reading_preferences", "users"
end
