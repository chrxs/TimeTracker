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

ActiveRecord::Schema.define(version: 20171009114324) do

  create_table "clients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "team_id"
    t.string   "name",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["team_id"], name: "index_clients_on_team_id", using: :btree
  end

  create_table "days", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.date     "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_days_on_user_id", using: :btree
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "client_id"
    t.string   "name",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["client_id"], name: "index_projects_on_client_id", using: :btree
  end

  create_table "teams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "name",       default: "",   null: false
    t.string   "slack_uid"
    t.boolean  "active",     default: true
    t.string   "domain"
    t.string   "image_34"
    t.string   "image_44"
    t.string   "image_68"
    t.string   "image_88"
    t.string   "image_102"
    t.string   "image_132"
    t.string   "image_230"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["name"], name: "index_teams_on_name", unique: true, using: :btree
    t.index ["slack_uid"], name: "index_teams_on_slack_uid", unique: true, using: :btree
    t.index ["user_id"], name: "index_teams_on_user_id", using: :btree
  end

  create_table "time_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "project_id"
    t.integer  "day_id"
    t.integer  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id"], name: "index_time_records_on_day_id", using: :btree
    t.index ["project_id"], name: "index_time_records_on_project_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",      default: "",    null: false
    t.string   "name",       default: "",    null: false
    t.string   "slack_uid",  default: "",    null: false
    t.string   "image_24"
    t.string   "image_32"
    t.string   "image_48"
    t.string   "image_72"
    t.string   "image_192"
    t.string   "image_512"
    t.boolean  "is_admin",   default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["slack_uid"], name: "index_users_on_slack_uid", unique: true, using: :btree
  end

  create_table "weekday_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "day_of_week"
    t.integer  "required_minutes_logged"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["user_id"], name: "index_weekday_settings_on_user_id", using: :btree
  end

end
