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

ActiveRecord::Schema.define(version: 20130909171359) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.integer  "creator_id"
    t.string   "title"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "description"
    t.integer  "upvote_count",   default: 0
    t.integer  "downvote_count", default: 0
    t.index ["creator_id"], name: "index_albums_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "parent_comment_id"
    t.integer  "album_id",                      null: false
    t.text     "body",                          null: false
    t.integer  "author_id",                     null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "upvote_count",      default: 0
    t.integer  "downvote_count",    default: 0
    t.index ["album_id"], name: "index_comments_on_album_id", using: :btree
    t.index ["author_id"], name: "index_comments_on_author_id", using: :btree
    t.index ["parent_comment_id"], name: "index_comments_on_parent_comment_id", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "uploader_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "album_id"
    t.index ["album_id"], name: "index_images_on_album_id", using: :btree
    t.index ["uploader_id"], name: "index_images_on_user_id", using: :btree
  end

  create_table "user_album_downvotes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "album_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id", "user_id"], name: "index_user_album_downvotes_on_album_id_and_user_id", unique: true, using: :btree
    t.index ["user_id", "album_id"], name: "index_user_album_downvotes_on_user_id_and_album_id", unique: true, using: :btree
  end

  create_table "user_album_favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "album_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id", "user_id"], name: "index_user_album_favorites_on_album_id_and_user_id", unique: true, using: :btree
    t.index ["user_id", "album_id"], name: "index_user_album_favorites_on_user_id_and_album_id", unique: true, using: :btree
  end

  create_table "user_album_upvotes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "album_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id", "user_id"], name: "index_user_album_upvotes_on_album_id_and_user_id", unique: true, using: :btree
    t.index ["user_id", "album_id"], name: "index_user_album_upvotes_on_user_id_and_album_id", unique: true, using: :btree
  end

  create_table "user_comment_downvotes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id", "user_id"], name: "index_user_comment_downvotes_on_comment_id_and_user_id", unique: true, using: :btree
    t.index ["user_id", "comment_id"], name: "index_user_comment_downvotes_on_user_id_and_comment_id", unique: true, using: :btree
  end

  create_table "user_comment_upvotes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id", "user_id"], name: "index_user_comment_upvotes_on_comment_id_and_user_id", unique: true, using: :btree
    t.index ["user_id", "comment_id"], name: "index_user_comment_upvotes_on_user_id_and_comment_id", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",        null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

end
