# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_07_152404) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "state"
    t.string "permalink"
    t.datetime "published_at"
    t.datetime "modified_at"
    t.bigint "site_id"
    t.boolean "noindex", default: false, null: false
    t.index ["site_id"], name: "index_articles_on_site_id"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "audits", force: :cascade do |t|
    t.string "auditable_type"
    t.bigint "auditable_id"
    t.string "user_type"
    t.bigint "user_id"
    t.text "modifications"
    t.string "action"
    t.string "tag"
    t.integer "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action"], name: "index_audits_on_action"
    t.index ["auditable_id", "auditable_type", "version"], name: "auditable_version_idx"
    t.index ["auditable_id", "auditable_type"], name: "auditable_index"
    t.index ["auditable_type", "auditable_id"], name: "index_audits_on_auditable_type_and_auditable_id"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["tag"], name: "index_audits_on_tag"
    t.index ["user_id", "user_type"], name: "user_index"
    t.index ["user_type", "user_id"], name: "index_audits_on_user_type_and_user_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "layout"
    t.text "description"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "user_sites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_user_sites_on_site_id"
    t.index ["user_id"], name: "index_user_sites_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
  end

  add_foreign_key "articles", "sites"
  add_foreign_key "taggings", "tags"
  add_foreign_key "user_sites", "sites"
  add_foreign_key "user_sites", "users"
end
