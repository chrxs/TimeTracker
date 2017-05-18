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

ActiveRecord::Schema.define(version: 20170428155436) do

  create_table "days", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "date"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       default: "", null: false
    t.string   "slack_uid"
    t.string   "domain"
    t.string   "image_34"
    t.string   "image_44"
    t.string   "image_68"
    t.string   "image_88"
    t.string   "image_102"
    t.string   "image_132"
    t.string   "image_230"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["name"], name: "index_teams_on_name", unique: true, using: :btree
  end

  create_table "time_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "project_id"
    t.integer  "day_id"
    t.integer  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",      default: "",    null: false
    t.string   "name",       default: "",    null: false
    t.string   "slack_uid"
    t.string   "image_24"
    t.string   "image_32"
    t.string   "image_48"
    t.string   "image_72"
    t.string   "image_192"
    t.string   "image_512"
    t.boolean  "is_admin",   default: false, null: false
    t.integer  "team_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  create_table "weekday_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "day_of_week"
    t.integer  "required_minutes_logged"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

end
