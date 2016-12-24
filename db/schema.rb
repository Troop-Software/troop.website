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

ActiveRecord::Schema.define(version: 20161224032342) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_file_uploads", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.index ["user_id"], name: "index_admin_file_uploads_on_user_id", using: :btree
  end

  create_table "article_categories", force: :cascade do |t|
    t.integer  "article_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  create_table "assignments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_assignments_on_role_id", using: :btree
    t.index ["user_id"], name: "index_assignments_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "start"
    t.datetime "end"
    t.boolean  "allDay"
    t.integer  "category"
    t.string   "external_link"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "merit_badges", force: :cascade do |t|
    t.string  "name"
    t.boolean "eagle_required"
  end

  create_table "patrols", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "positions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ranks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "scout_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scout_id"], name: "index_relationships_on_scout_id", using: :btree
    t.index ["user_id"], name: "index_relationships_on_user_id", using: :btree
  end

  create_table "requirements", force: :cascade do |t|
    t.integer  "revision"
    t.integer  "rank_id"
    t.integer  "req_category"
    t.string   "req_num"
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "sortOrder"
    t.boolean  "bor"
    t.boolean  "mb"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scout_events", force: :cascade do |t|
    t.integer  "scout_id"
    t.integer  "event_id"
    t.string   "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scout_id", "event_id"], name: "index_scout_events_on_scout_id_and_event_id", unique: true, using: :btree
  end

  create_table "scout_merit_badges", force: :cascade do |t|
    t.integer  "scout_id"
    t.integer  "merit_badge_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.date     "completed"
  end

  create_table "scout_positions", force: :cascade do |t|
    t.integer  "scout_id"
    t.integer  "position_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["position_id"], name: "index_scout_positions_on_position_id", using: :btree
    t.index ["scout_id", "position_id", "start_date"], name: "unique_entry", unique: true, using: :btree
    t.index ["scout_id"], name: "index_scout_positions_on_scout_id", using: :btree
  end

  create_table "scout_rank_histories", force: :cascade do |t|
    t.integer  "scout_id"
    t.integer  "rank_id"
    t.date     "rank_completed"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "scout_requirements", force: :cascade do |t|
    t.integer  "scout_id"
    t.integer  "requirement_id"
    t.string   "sign_off"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.date     "completed_date"
  end

  create_table "scout_trainings", force: :cascade do |t|
    t.integer  "scout_id"
    t.integer  "youth_training_id"
    t.date     "completed_date"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["scout_id"], name: "index_scout_trainings_on_scout_id", using: :btree
    t.index ["youth_training_id"], name: "index_scout_trainings_on_youth_training_id", using: :btree
  end

  create_table "scouts", force: :cascade do |t|
    t.string   "name"
    t.integer  "grade"
    t.date     "birthdate"
    t.integer  "patrol_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "rank_id"
    t.string   "email"
    t.string   "phone"
    t.date     "joined"
    t.integer  "bsa_id"
    t.boolean  "active",     default: true
    t.index ["patrol_id"], name: "index_scouts_on_patrol_id", using: :btree
    t.index ["rank_id"], name: "index_scouts_on_rank_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.jsonb    "settings",               default: {}, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  create_table "youth_trainings", force: :cascade do |t|
    t.string   "name"
    t.string   "abbr"
    t.string   "bsa_code"
    t.string   "description"
    t.string   "url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "admin_file_uploads", "users"
  add_foreign_key "assignments", "roles"
  add_foreign_key "assignments", "users"
  add_foreign_key "relationships", "scouts"
  add_foreign_key "relationships", "users"
  add_foreign_key "scout_positions", "positions"
  add_foreign_key "scout_positions", "scouts"
  add_foreign_key "scout_trainings", "scouts"
  add_foreign_key "scout_trainings", "youth_trainings"
  add_foreign_key "scouts", "patrols"
end
