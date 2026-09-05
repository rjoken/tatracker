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

ActiveRecord::Schema[8.1].define(version: 2026_09_05_001540) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "tracker_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "image_name"
    t.integer "position"
    t.bigint "tracker_room_id", null: false
    t.datetime "updated_at", null: false
    t.integer "value"
    t.index ["tracker_room_id"], name: "index_tracker_items_on_tracker_room_id"
  end

  create_table "tracker_rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "slug"
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_tracker_rooms_on_slug", unique: true
  end

  add_foreign_key "tracker_items", "tracker_rooms"
end
