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

ActiveRecord::Schema.define(version: 20170409211633) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "follows", force: :cascade do |t|
    t.string   "followable_type",                 null: false
    t.integer  "followable_id",                   null: false
    t.string   "follower_type",                   null: false
    t.integer  "follower_id",                     null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["followable_id", "followable_type"], name: "fk_followables", using: :btree
    t.index ["follower_id", "follower_type"], name: "fk_follows", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_groups_on_user_id", using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "order_id"
    t.integer  "amount"
    t.float    "price"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_items_on_order_id", using: :btree
    t.index ["user_id"], name: "index_items_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id", using: :btree
  end

  create_table "order_details", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "joined"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "order_id"
    t.index ["order_id"], name: "index_order_details_on_order_id", using: :btree
    t.index ["user_id"], name: "index_order_details_on_user_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.string   "meal"
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "restaurant"
    t.integer  "joined"
    t.integer  "invited"
    t.string   "status"
    t.text     "image"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "order_image_file_name"
    t.string   "order_image_content_type"
    t.integer  "order_image_file_size"
    t.datetime "order_image_updated_at"
    t.index ["group_id"], name: "index_orders_on_group_id", using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "user_groups", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_user_groups_on_group_id", using: :btree
    t.index ["user_id"], name: "index_user_groups_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.boolean  "gender"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "groups", "users"
  add_foreign_key "items", "orders"
  add_foreign_key "items", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "users"
  add_foreign_key "orders", "groups"
  add_foreign_key "orders", "users"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "users"
end
