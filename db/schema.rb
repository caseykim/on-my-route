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

ActiveRecord::Schema.define(version: 20151008193233) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "constructions", force: :cascade do |t|
    t.integer  "line_id",          null: false
    t.integer  "start_station_id", null: false
    t.integer  "end_station_id",   null: false
    t.date     "start_date",       null: false
    t.date     "end_date",         null: false
    t.string   "start_time",       null: false
    t.string   "end_time"
    t.string   "description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
  end

  add_index "constructions", ["line_id"], name: "index_constructions_on_line_id", using: :btree

  create_table "lines", force: :cascade do |t|
    t.string "name",  null: false
    t.string "color"
  end

  add_index "lines", ["name"], name: "index_lines_on_name", unique: true, using: :btree

  create_table "lines_stations", force: :cascade do |t|
    t.integer "line_id",          null: false
    t.integer "station_id",       null: false
    t.integer "station_sequence", null: false
  end

  add_index "lines_stations", ["line_id", "station_id"], name: "index_lines_stations_on_line_id_and_station_id", unique: true, using: :btree

  create_table "reminders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stations", force: :cascade do |t|
    t.string "name", null: false
  end

  add_index "stations", ["name"], name: "index_stations_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",                 null: false
    t.string   "encrypted_password",     default: "",                 null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "image",                  default: "/thomastrain.jpg"
    t.string   "name"
    t.string   "phone_number"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
