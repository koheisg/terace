# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_05_30_133338) do

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
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "archives", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "archiveable_type", null: false
    t.bigint "archiveable_id", null: false
    t.index ["archiveable_type", "archiveable_id"], name: "index_archives_on_archiveable_type_and_archiveable_id"
  end

  create_table "articles", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["auditable_type", "auditable_id"], name: "index_audits_on_auditable"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["tag"], name: "index_audits_on_tag"
    t.index ["user_id", "user_type"], name: "user_index"
    t.index ["user_type", "user_id"], name: "index_audits_on_user"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.bigint "site_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "permalinks_count"
    t.index ["site_id"], name: "index_categories_on_site_id"
  end

  create_table "pages", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "permalinks", force: :cascade do |t|
    t.string "permalinkable_type", null: false
    t.bigint "permalinkable_id", null: false
    t.bigint "site_id", null: false
    t.integer "state"
    t.string "path"
    t.string "title"
    t.string "description"
    t.boolean "noindex"
    t.datetime "published_at"
    t.datetime "modified_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "category_id"
    t.string "og_image_url"
    t.index ["category_id"], name: "index_permalinks_on_category_id"
    t.index ["permalinkable_type", "permalinkable_id"], name: "index_permalinks_on_permalinkable_type_and_permalinkable_id"
    t.index ["site_id"], name: "index_permalinks_on_site_id"
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
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "site_id", null: false
    t.integer "taggings_count"
    t.index ["name"], name: "index_tags_on_name", unique: true
    t.index ["site_id"], name: "index_tags_on_site_id"
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

  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "categories", "sites"
  add_foreign_key "permalinks", "categories"
  add_foreign_key "permalinks", "sites"
  add_foreign_key "taggings", "tags"
  add_foreign_key "tags", "sites"
  add_foreign_key "user_sites", "sites"
  add_foreign_key "user_sites", "users"
end
