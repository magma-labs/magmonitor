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

ActiveRecord::Schema.define(version: 20170815170119) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "check_locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "redis_url"
  end

  create_table "invites", force: :cascade do |t|
    t.string "email"
    t.integer "organization_id"
    t.integer "sender_id"
    t.integer "recipient_id"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "organization_id"
    t.bigint "user_id"
    t.boolean "active"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_memberships_on_organization_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "contact_email"
    t.string "slug"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "site_check_results", force: :cascade do |t|
    t.string "raw_response"
    t.integer "response_code"
    t.string "http_response"
    t.integer "response_time"
    t.integer "check_location_id"
    t.integer "site_check_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "site_checks", force: :cascade do |t|
    t.string "name"
    t.string "target_url"
    t.string "basic_auth"
    t.string "check_type", default: "http"
    t.string "user_agent"
    t.integer "check_rate", default: 300
    t.integer "site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.integer "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sites_check_locations", force: :cascade do |t|
    t.bigint "site_check_id"
    t.bigint "check_location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["check_location_id"], name: "index_sites_check_locations_on_check_location_id"
    t.index ["site_check_id"], name: "index_sites_check_locations_on_site_check_id"
  end

  create_table "user_groups", force: :cascade do |t|
    t.string "name"
    t.bigint "organization_id"
    t.index ["organization_id"], name: "index_user_groups_on_organization_id"
  end

  create_table "user_groups_users", id: false, force: :cascade do |t|
    t.bigint "user_group_id", null: false
    t.bigint "user_id", null: false
    t.index ["user_group_id", "user_id"], name: "index_user_groups_users_on_user_group_id_and_user_id"
    t.index ["user_id", "user_group_id"], name: "index_user_groups_users_on_user_id_and_user_group_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "image"
    t.boolean "fully_registered", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
