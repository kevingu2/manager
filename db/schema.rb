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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20150708192123) do
=======
ActiveRecord::Schema.define(version: 20150707185042) do

  create_table "allocated_tasks", force: true do |t|
    t.string   "title"
    t.string   "taskId"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
>>>>>>> f3f52c401a974d67b7a4f6359d62e10629151fad

  create_table "histories", force: true do |t|
    t.integer  "oppty_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "histories", ["oppty_id"], name: "index_histories_on_oppty_id"
  add_index "histories", ["user_id"], name: "index_histories_on_user_id"

  create_table "oppties", force: true do |t|
    t.string   "opptyId"
    t.string   "opptyName"
    t.string   "idiqCA"
    t.string   "status2"
    t.float    "value"
    t.integer  "pWin"
    t.string   "captureMgr"
    t.string   "programMgr"
    t.string   "proposalMgr"
    t.string   "sslOrg"
    t.string   "technicalLead"
    t.string   "slArch"
    t.string   "ed"
    t.string   "on"
    t.string   "ate"
    t.string   "slComments"
    t.date     "rfpDate"
    t.date     "awardDate"
    t.date     "submitDate"
    t.boolean  "done",            default: false
    t.date     "proposalDueDate"
    t.string   "slDir"
    t.string   "leadEstim"
    t.string   "engaged"
    t.string   "solution"
    t.string   "estimate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_oppties", force: true do |t|
    t.integer  "oppty_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",     default: 2
  end

  add_index "user_oppties", ["oppty_id"], name: "index_user_oppties_on_oppty_id"
  add_index "user_oppties", ["user_id"], name: "index_user_oppties_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
