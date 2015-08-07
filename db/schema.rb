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

ActiveRecord::Schema.define(version: 20150804095711) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "username",               limit: 255
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "author", force: :cascade do |t|
    t.string "title",     limit: 255,      null: false
    t.string "slug",      limit: 255,      null: false
    t.text   "biography", limit: 16777215, null: false
  end

  add_index "author", ["slug"], name: "slug", unique: true, using: :btree
  add_index "author", ["title"], name: "title", unique: true, using: :btree

  create_table "authors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "banners", force: :cascade do |t|
    t.string   "banner_name", limit: 255
    t.string   "author_name", limit: 255
    t.string   "link",        limit: 255
    t.string   "image",       limit: 255
    t.integer  "clicks",      limit: 4,   default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "blocks", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "group_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "blocks", ["group_id"], name: "index_blocks_on_group_id", using: :btree

  create_table "book", force: :cascade do |t|
    t.text    "title",             limit: 65535,    null: false
    t.string  "author",            limit: 255,      null: false
    t.integer "author_id",         limit: 4,        null: false
    t.text    "author_bio",        limit: 16777215, null: false
    t.string  "authors",           limit: 255,      null: false
    t.string  "title_slug",        limit: 255,      null: false
    t.string  "author_slug",       limit: 255,      null: false
    t.string  "isbn13",            limit: 255,      null: false
    t.string  "isbn10",            limit: 255,      null: false
    t.string  "price",             limit: 255,      null: false
    t.string  "format",            limit: 255,      null: false
    t.string  "publisher",         limit: 255,      null: false
    t.string  "pubdate",           limit: 255,      null: false
    t.string  "edition",           limit: 255,      null: false
    t.string  "subjects",          limit: 255,      null: false
    t.string  "lexile",            limit: 255,      null: false
    t.string  "pages",             limit: 255,      null: false
    t.string  "dimensions",        limit: 255,      null: false
    t.text    "overview",          limit: 16777215, null: false
    t.text    "excerpt",           limit: 16777215, null: false
    t.text    "synopsis",          limit: 65535,    null: false
    t.text    "toc",               limit: 16777215, null: false
    t.text    "editorial_reviews", limit: 16777215, null: false
    t.string  "image_url",         limit: 255
  end

  add_index "book", ["author"], name: "author", using: :btree
  add_index "book", ["author_id"], name: "author_id", using: :btree
  add_index "book", ["author_slug"], name: "author_slug", using: :btree
  add_index "book", ["isbn10"], name: "isbn10", using: :btree
  add_index "book", ["isbn13"], name: "isbn13", unique: true, using: :btree
  add_index "book", ["subjects"], name: "index_book_on_subjects", using: :btree
  add_index "book", ["subjects"], name: "subjects", using: :btree
  add_index "book", ["title"], name: "title", length: {"title"=>10}, using: :btree
  add_index "book", ["title_slug"], name: "title_slug", using: :btree

  create_table "book2subjects", force: :cascade do |t|
    t.integer "book",            limit: 4, null: false
    t.integer "sub_subject",     limit: 4, null: false
    t.integer "sub_sub_subject", limit: 4, null: false
  end

  add_index "book2subjects", ["book", "sub_subject", "sub_sub_subject"], name: "book", unique: true, using: :btree
  add_index "book2subjects", ["sub_sub_subject"], name: "sub_sub_subject", using: :btree
  add_index "book2subjects", ["sub_subject", "sub_sub_subject"], name: "sub_subject", using: :btree

  create_table "book_old", force: :cascade do |t|
    t.text    "title",             limit: 65535,    null: false
    t.string  "author",            limit: 255,      null: false
    t.integer "author_id",         limit: 4,        null: false
    t.text    "author_bio",        limit: 16777215, null: false
    t.string  "authors",           limit: 255,      null: false
    t.string  "title_slug",        limit: 255,      null: false
    t.string  "author_slug",       limit: 255,      null: false
    t.string  "isbn13",            limit: 255,      null: false
    t.string  "isbn10",            limit: 255,      null: false
    t.string  "price",             limit: 255,      null: false
    t.string  "format",            limit: 255,      null: false
    t.string  "publisher",         limit: 255,      null: false
    t.string  "pubdate",           limit: 255,      null: false
    t.string  "edition",           limit: 255,      null: false
    t.string  "subjects",          limit: 255,      null: false
    t.string  "lexile",            limit: 255,      null: false
    t.string  "pages",             limit: 255,      null: false
    t.string  "dimensions",        limit: 255,      null: false
    t.text    "overview",          limit: 16777215, null: false
    t.text    "excerpt",           limit: 16777215, null: false
    t.text    "synopsis",          limit: 65535,    null: false
    t.text    "toc",               limit: 16777215, null: false
    t.text    "editorial_reviews", limit: 16777215, null: false
  end

  add_index "book_old", ["author"], name: "author", using: :btree
  add_index "book_old", ["author_id"], name: "author_id", using: :btree
  add_index "book_old", ["author_slug"], name: "author_slug", using: :btree
  add_index "book_old", ["isbn10"], name: "isbn10", using: :btree
  add_index "book_old", ["isbn13"], name: "isbn13", unique: true, using: :btree
  add_index "book_old", ["subjects"], name: "index_book_old_on_subjects", using: :btree
  add_index "book_old", ["subjects"], name: "subjects", using: :btree
  add_index "book_old", ["title"], name: "title", length: {"title"=>10}, using: :btree
  add_index "book_old", ["title_slug"], name: "title_slug", using: :btree

  create_table "books", force: :cascade do |t|
    t.text     "title",                 limit: 65535,               null: false
    t.string   "author",                limit: 255,                 null: false
    t.string   "genre",                 limit: 255,                 null: false
    t.string   "upload_type",           limit: 255,                 null: false
    t.integer  "user_id",               limit: 4
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.float    "latitude",              limit: 24,    default: 0.0, null: false
    t.float    "longitude",             limit: 24,    default: 0.0, null: false
    t.string   "address",               limit: 255,   default: "",  null: false
    t.datetime "upload_date"
    t.date     "upload_date_for_admin"
    t.string   "isbn13",                limit: 255
    t.string   "image_path",            limit: 255
    t.text     "about_us",              limit: 65535
  end

  create_table "contact_us", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "email",       limit: 255
    t.string   "country",     limit: 255
    t.string   "gender",      limit: 255
    t.string   "author_code", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "devices", force: :cascade do |t|
    t.string   "device_id",   limit: 255
    t.string   "device_type", limit: 255
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "documents", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "get_book_id",     limit: 4
    t.integer  "give_book_id",    limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "admin_id",        limit: 4
    t.integer  "get_preference",  limit: 4
    t.integer  "give_preference", limit: 4
  end

  create_table "invitations", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.string   "invitation_type",   limit: 255
    t.integer  "attendee",          limit: 4
    t.string   "status",            limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "book_to_get",       limit: 4
    t.integer  "book_to_give",      limit: 4
    t.string   "invitation_status", limit: 255
  end

  add_index "invitations", ["user_id"], name: "index_invitations_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "message",    limit: 255
    t.integer  "sender_id",  limit: 4
    t.string   "media",      limit: 255
    t.integer  "group_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "messages", ["group_id"], name: "index_messages_on_group_id", using: :btree

  create_table "notices", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.string   "action_type",   limit: 255
    t.integer  "reciever_id",   limit: 4
    t.boolean  "pending",       limit: 1
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "invitation_id", limit: 4
    t.integer  "book_to_give",  limit: 4
  end

  add_index "notices", ["user_id"], name: "index_notices_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.string   "subject",       limit: 255
    t.text     "content",       limit: 65535
    t.string   "location",      limit: 255
    t.string   "author",        limit: 255
    t.string   "genre",         limit: 255
    t.string   "all",           limit: 255
    t.string   "sub_locations", limit: 255,   default: "{}"
    t.string   "sub_authors",   limit: 255,   default: "{}"
    t.string   "sub_genres",    limit: 255,   default: "{}"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "privacy_policies", force: :cascade do |t|
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.float    "insights",          limit: 24
    t.float    "contributor",       limit: 24
    t.float    "social",            limit: 24
    t.float    "overallexperience", limit: 24
    t.string   "comment",           limit: 255
    t.integer  "group_id",          limit: 4
    t.integer  "ratable_id",        limit: 4
    t.integer  "user_id",           limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "reading_preferences", force: :cascade do |t|
    t.text     "title",              limit: 65535,                 null: false
    t.string   "author",             limit: 255,                   null: false
    t.string   "genre",              limit: 255,                   null: false
    t.integer  "user_id",            limit: 4
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.boolean  "book_deactivated",   limit: 1,     default: false
    t.boolean  "author_deactivated", limit: 1,     default: false
    t.boolean  "genre_deactivated",  limit: 1,     default: false
    t.string   "isbn13",             limit: 255
    t.string   "image_path",         limit: 255
    t.boolean  "delete_author",      limit: 1,     default: false
    t.boolean  "delete_genre",       limit: 1,     default: false
    t.boolean  "by_scanning",        limit: 1,     default: false
  end

  add_index "reading_preferences", ["user_id"], name: "index_reading_preferences_on_user_id", using: :btree

  create_table "scanning_subjects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sub_sub_subject", force: :cascade do |t|
    t.string  "title",       limit: 255, null: false
    t.integer "sub_subject", limit: 2,   null: false
    t.string  "slug",        limit: 255, null: false
    t.integer "count",       limit: 4,   null: false
  end

  add_index "sub_sub_subject", ["slug"], name: "slug", using: :btree
  add_index "sub_sub_subject", ["sub_subject", "slug"], name: "sub_subject", using: :btree

  create_table "sub_subject", force: :cascade do |t|
    t.string  "title",   limit: 255, null: false
    t.integer "subject", limit: 2,   null: false
    t.string  "slug",    limit: 255, null: false
    t.integer "count",   limit: 4,   null: false
  end

  add_index "sub_subject", ["slug"], name: "slug", using: :btree
  add_index "sub_subject", ["subject", "slug"], name: "subject", unique: true, using: :btree

  create_table "subject", force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.string "slug",  limit: 255, null: false
  end

  add_index "subject", ["slug"], name: "slug", unique: true, using: :btree

  create_table "terms_and_conditions", force: :cascade do |t|
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

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
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.float    "latitude",               limit: 24,    default: 0.0,   null: false
    t.float    "longitude",              limit: 24,    default: 0.0,   null: false
    t.string   "provider",               limit: 255,   default: "",    null: false
    t.string   "u_id",                   limit: 255,   default: "",    null: false
    t.string   "device_used",            limit: 255
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.string   "address",                limit: 255,   default: "",    null: false
    t.text     "about_me",               limit: 65535
    t.boolean  "is_block",               limit: 1,     default: false
    t.date     "weekly_date"
    t.boolean  "notification_status",    limit: 1,     default: true
    t.string   "sign_in_token",          limit: 255
    t.integer  "mat_books_count",        limit: 4,     default: 0
    t.integer  "mat_author_count",       limit: 4,     default: 0
    t.integer  "mat_genre_count",        limit: 4,     default: 0
    t.integer  "within_five_km",         limit: 4,     default: 0
    t.date     "date_within_five_km"
  end

  create_table "users_groups", id: false, force: :cascade do |t|
    t.integer "user_id",  limit: 4
    t.integer "group_id", limit: 4
  end

  add_foreign_key "blocks", "groups"
  add_foreign_key "devices", "users"
  add_foreign_key "invitations", "users"
  add_foreign_key "messages", "groups"
  add_foreign_key "notices", "users"
  add_foreign_key "ratings", "users"
  add_foreign_key "reading_preferences", "users"
end
