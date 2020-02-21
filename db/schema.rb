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

ActiveRecord::Schema.define(version: 2020_02_15_182148) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "numbers", force: :cascade do |t|
    t.string "number"
    t.boolean "skip_sign_up", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pics", force: :cascade do |t|
    t.bigint "number_id"
    t.string "description"
    t.string "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number_id"], name: "index_pics_on_number_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "number_id"
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "users", "numbers"
end
