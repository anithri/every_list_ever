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

ActiveRecord::Schema[8.0].define(version: 2025_01_11_203614) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.string "subtitle"
    t.text "description"
    t.bigint "user_id", null: false
    t.boolean "visible", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_organizations_on_name", unique: true
    t.index ["user_id"], name: "index_organizations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "visible", default: "false", null: false
    t.integer "site_role", default: 0, null: false
    t.string "location"
    t.text "description"
    t.string "avatar_url"
    t.json "settings", default: {"theme" => "light"}, null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "confirmed_at"
    t.datetime "deleted_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["confirmed_at"], name: "index_users_on_confirmed", where: "(deleted_at IS NULL)"
    t.index ["confirmed_at"], name: "index_users_on_confirmed_at_null", where: "(deleted_at IS NULL)"
    t.index ["deleted_at"], name: "index_users_on_deleted_at", where: "(deleted_at IS NOT NULL)"
    t.index ["deleted_at"], name: "index_users_on_deleted_at_null", where: "(deleted_at IS NULL)"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["remember_token"], name: "index_users_on_remember_token", unique: true
    t.index ["site_role"], name: "index_users_on_site_role"
    t.index ["visible"], name: "index_users_on_visible"
  end

  add_foreign_key "organizations", "users"
end
