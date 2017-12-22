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

ActiveRecord::Schema.define(version: 20171003205434) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "school"
    t.string   "pathway"
    t.string   "activity"
    t.integer  "grade"
    t.integer  "ninth_graders",    default: 0
    t.integer  "tenth_graders",    default: 0
    t.integer  "eleventh_graders", default: 0
    t.integer  "twelfth_graders",  default: 0
    t.datetime "date"
    t.datetime "start_time"
    t.integer  "teacher_id"
    t.datetime "end_time"
    t.integer  "provider_id"
    t.string   "location"
    t.index ["provider_id"], name: "index_events_on_provider_id", using: :btree
    t.index ["teacher_id"], name: "index_events_on_teacher_id", using: :btree
  end

  create_table "events_users", id: false, force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "user_id",  null: false
  end

  create_table "providers", force: :cascade do |t|
    t.string   "location"
    t.string   "url",          default: "N/A"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "organization"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "surveys", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "complete",            default: false
    t.string   "question1"
    t.string   "question2"
    t.string   "question3"
    t.string   "question4"
    t.text     "question5"
    t.boolean  "career_awareness",    default: false
    t.boolean  "workplace_protocols", default: false
    t.boolean  "field_interest",      default: false
    t.boolean  "career_skills",       default: false
    t.boolean  "gain_confidence",     default: false
    t.boolean  "project",             default: false
    t.boolean  "creative_thinking",   default: false
    t.boolean  "teamwork_skills",     default: false
    t.boolean  "take_feedback",       default: false
    t.boolean  "self_management",     default: false
    t.boolean  "assess_learning",     default: false
    t.boolean  "develop_plan",        default: false
    t.string   "teacher_question3"
    t.index ["event_id"], name: "index_surveys_on_event_id", using: :btree
    t.index ["user_id"], name: "index_surveys_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "school"
    t.integer  "grade"
    t.text     "password_hint"
    t.string   "access_level"
    t.integer  "student_number"
    t.string   "gender"
    t.string   "ethnicity"
    t.string   "pathway"
    t.string   "username"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  create_table "views", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_views_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_views_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "surveys", "events"
  add_foreign_key "surveys", "users"
end
