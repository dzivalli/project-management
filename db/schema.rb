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

ActiveRecord::Schema.define(version: 20150204114833) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.string   "email"
    t.string   "address",    default: "", null: false
    t.string   "city"
    t.string   "website"
    t.integer  "phone"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_to"
    t.integer  "users_id"
    t.text     "message"
    t.string   "status"
    t.string   "attached_file"
    t.date     "date_received"
    t.boolean  "deleted"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "milestones", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.date     "start_date"
    t.date     "due_date"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "milestones", ["project_id"], name: "index_milestones_on_project_id", using: :btree

  create_table "permissions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.string   "subject_class"
    t.integer  "subject_id"
    t.string   "action"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "permissions", ["company_id"], name: "index_permissions_on_company_id", using: :btree
  add_index "permissions", ["user_id"], name: "index_permissions_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "title",           null: false
    t.text     "description"
    t.date     "start_date"
    t.date     "due_date"
    t.boolean  "fixed_price"
    t.float    "fixed_rate"
    t.float    "hourly_rate"
    t.string   "status"
    t.boolean  "deleted"
    t.text     "notes"
    t.integer  "estimated_hours"
    t.integer  "progress"
    t.integer  "company_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "projects_users", id: false, force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "user_id",    null: false
  end

  add_index "projects_users", ["user_id", "project_id"], name: "index_projects_users_on_user_id_and_project_id", unique: true, using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", id: false, force: :cascade do |t|
    t.string   "key",        null: false
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "settings", ["key"], name: "index_settings_on_key", unique: true, using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "estimated_hours"
    t.date     "due_date"
    t.integer  "project_id"
    t.integer  "milestone_id"
    t.boolean  "visible"
    t.integer  "progress"
    t.integer  "user_id"
    t.boolean  "auto_progress"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "tasks", ["milestone_id"], name: "index_tasks_on_milestone_id", using: :btree
  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id", using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "tasks_users", id: false, force: :cascade do |t|
    t.integer "task_id", null: false
    t.integer "user_id", null: false
  end

  add_index "tasks_users", ["user_id", "task_id"], name: "index_tasks_users_on_user_id_and_task_id", unique: true, using: :btree

  create_table "tickets", force: :cascade do |t|
    t.string   "subject"
    t.text     "body"
    t.string   "status"
    t.integer  "priority"
    t.text     "additional"
    t.string   "attachment"
    t.integer  "users_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_entries", force: :cascade do |t|
    t.date     "start_time"
    t.date     "end_time"
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "time_entries", ["project_id"], name: "index_time_entries_on_project_id", using: :btree
  add_index "time_entries", ["task_id"], name: "index_time_entries_on_task_id", using: :btree
  add_index "time_entries", ["user_id"], name: "index_time_entries_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",               default: "", null: false
    t.string   "full_name",              default: "", null: false
    t.string   "phone"
    t.integer  "role_id"
    t.integer  "company_id"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "milestones", "projects"
  add_foreign_key "permissions", "companies"
  add_foreign_key "permissions", "users"
  add_foreign_key "tasks", "milestones"
  add_foreign_key "tasks", "projects"
  add_foreign_key "tasks", "users"
  add_foreign_key "time_entries", "projects"
  add_foreign_key "time_entries", "tasks"
  add_foreign_key "time_entries", "users"
end
