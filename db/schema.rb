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

ActiveRecord::Schema.define(version: 20150306115205) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string   "file"
    t.text     "description"
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "attachments", ["project_id"], name: "index_attachments_on_project_id", using: :btree
  add_index "attachments", ["user_id"], name: "index_attachments_on_user_id", using: :btree

  create_table "clients", force: :cascade do |t|
    t.integer  "main_company_id"
    t.integer  "owner_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "clients", ["main_company_id", "owner_id"], name: "index_clients_on_main_company_id_and_owner_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.string   "email"
    t.string   "address",    default: "", null: false
    t.string   "city"
    t.string   "website"
    t.integer  "phone"
    t.integer  "contact_id"
    t.integer  "client_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "email_templates", force: :cascade do |t|
    t.string   "name"
    t.text     "body"
    t.integer  "group"
    t.integer  "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "email_templates", ["client_id"], name: "index_email_templates_on_client_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.string   "reference_no"
    t.integer  "company_id"
    t.date     "due_date"
    t.text     "notes"
    t.float    "tax",              default: 0.0
    t.integer  "discount"
    t.boolean  "recurring"
    t.integer  "recur_freq"
    t.date     "recur_start_date"
    t.date     "recur_end_date"
    t.date     "recur_next_date"
    t.integer  "status"
    t.integer  "archived"
    t.date     "sent_date"
    t.boolean  "deleted"
    t.boolean  "emailed"
    t.boolean  "visible"
    t.boolean  "viewed"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "invoices", ["company_id"], name: "index_invoices_on_company_id", using: :btree

  create_table "item_templates", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "cost"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "client_id"
  end

  add_index "item_templates", ["client_id"], name: "index_item_templates_on_client_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "cost"
    t.integer  "quantity"
    t.integer  "invoice_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "items", ["invoice_id"], name: "index_items_on_invoice_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "recipients",    default: [], null: false, array: true
    t.integer  "user_id"
    t.text     "message"
    t.string   "status"
    t.string   "attached_file"
    t.date     "date_received"
    t.boolean  "deleted"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "milestone_templates", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "client_id"
  end

  add_index "milestone_templates", ["client_id"], name: "index_milestone_templates_on_client_id", using: :btree

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

  create_table "payment_methods", force: :cascade do |t|
    t.string "name"
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "invoice_id"
    t.integer  "company_id"
    t.string   "payer_email"
    t.integer  "payment_method_id"
    t.float    "amount"
    t.string   "trans"
    t.date     "payment_date"
    t.boolean  "deleted"
    t.text     "notes"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "payments", ["company_id"], name: "index_payments_on_company_id", using: :btree
  add_index "payments", ["invoice_id"], name: "index_payments_on_invoice_id", using: :btree
  add_index "payments", ["payment_method_id"], name: "index_payments_on_payment_method_id", using: :btree

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
    t.string   "name",            null: false
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
    t.integer  "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "settings", ["key"], name: "index_settings_on_key", unique: true, using: :btree

  create_table "task_templates", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "estimated_hours"
    t.boolean  "visible"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "milestone_template_id"
    t.integer  "client_id"
  end

  add_index "task_templates", ["client_id"], name: "index_task_templates_on_client_id", using: :btree
  add_index "task_templates", ["milestone_template_id"], name: "index_task_templates_on_milestone_template_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "estimated_hours"
    t.date     "due_date"
    t.integer  "project_id"
    t.integer  "milestone_id"
    t.boolean  "visible"
    t.integer  "owner_id"
    t.boolean  "auto_progress"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "tasks", ["milestone_id"], name: "index_tasks_on_milestone_id", using: :btree
  add_index "tasks", ["owner_id"], name: "index_tasks_on_owner_id", using: :btree
  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id", using: :btree

  create_table "tasks_users", id: false, force: :cascade do |t|
    t.integer "task_id", null: false
    t.integer "user_id", null: false
  end

  add_index "tasks_users", ["user_id", "task_id"], name: "index_tasks_users_on_user_id_and_task_id", unique: true, using: :btree

  create_table "ticket_replies", force: :cascade do |t|
    t.text     "body"
    t.integer  "ticket_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ticket_replies", ["ticket_id"], name: "index_ticket_replies_on_ticket_id", using: :btree
  add_index "ticket_replies", ["user_id"], name: "index_ticket_replies_on_user_id", using: :btree

  create_table "tickets", force: :cascade do |t|
    t.string   "subject"
    t.string   "code"
    t.text     "body"
    t.integer  "status"
    t.integer  "priority"
    t.text     "additional"
    t.string   "attachment"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_entries", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "task_id"
    t.string   "status"
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
    t.integer  "client_id"
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "avatar_id"
  end

  add_index "users", ["avatar_id"], name: "index_users_on_avatar_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.json     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "attachments", "projects"
  add_foreign_key "attachments", "users"
  add_foreign_key "email_templates", "clients"
  add_foreign_key "invoices", "companies"
  add_foreign_key "item_templates", "clients"
  add_foreign_key "items", "invoices"
  add_foreign_key "messages", "users"
  add_foreign_key "milestone_templates", "clients"
  add_foreign_key "milestones", "projects"
  add_foreign_key "payments", "companies"
  add_foreign_key "payments", "invoices"
  add_foreign_key "payments", "payment_methods"
  add_foreign_key "permissions", "companies"
  add_foreign_key "permissions", "users"
  add_foreign_key "settings", "clients"
  add_foreign_key "task_templates", "clients"
  add_foreign_key "task_templates", "milestone_templates"
  add_foreign_key "tasks", "milestones"
  add_foreign_key "tasks", "projects"
  add_foreign_key "ticket_replies", "tickets"
  add_foreign_key "ticket_replies", "users"
  add_foreign_key "time_entries", "projects"
  add_foreign_key "time_entries", "tasks"
  add_foreign_key "time_entries", "users"
  add_foreign_key "users", "companies"
  add_foreign_key "users", "roles"
end
