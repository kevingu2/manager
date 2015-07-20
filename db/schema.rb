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

ActiveRecord::Schema.define(version: 20150720155043) do

  create_table "allocated_tasks", force: true do |t|
    t.string   "title"
    t.string   "taskId"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.float    "pWin"
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
    t.boolean  "done",                  default: false
    t.date     "proposalDueDate"
    t.string   "slDir"
    t.string   "leadEstim"
    t.string   "engaged"
    t.string   "solution"
    t.string   "estimate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "codeName"
    t.string   "descriptionOfWork"
    t.string   "category"
    t.string   "pwald"
    t.float    "pBid"
    t.float    "awardFV"
    t.float    "saicvaPercent"
    t.float    "saicva"
    t.float    "mat"
    t.float    "materialsTV"
    t.float    "subc"
    t.float    "subTV"
    t.float    "cg_va"
    t.float    "sss_va"
    t.float    "nwi_va"
    t.float    "hwi_va"
    t.float    "itms_va"
    t.float    "tss_va"
    t.float    "ccds_va"
    t.float    "mss_va"
    t.float    "swi_va"
    t.float    "lsc_va"
    t.float    "zzOth_va"
    t.float    "pri"
    t.string   "aop"
    t.string   "peg"
    t.string   "mustWin"
    t.string   "feeIndic"
    t.string   "slutil"
    t.string   "recompete"
    t.string   "competitive"
    t.string   "international"
    t.string   "strategic"
    t.string   "bundle"
    t.string   "bidReviewStream"
    t.string   "definedDelivPgm"
    t.string   "evaluationCriteria"
    t.string   "perfWorkLoc"
    t.string   "classIfReqmt"
    t.string   "grouping"
    t.string   "reasonForWinLoss"
    t.float    "egr"
    t.string   "slCat"
    t.string   "slPri"
    t.string   "slNote"
    t.date     "crmRunDate"
    t.date     "contractStartDate"
    t.string   "rfpFYPer"
    t.string   "submitFYPer"
    t.string   "awardFYPer"
    t.string   "preBPprojID"
    t.float    "fy16PreBP"
    t.float    "fy16PreBPSpent"
    t.float    "fy16PreBPSpentPercent"
    t.string   "bpProjID"
    t.float    "fy16BDTot"
    t.float    "fy16BDTotSpent"
    t.float    "fy16BDTotSpentPercent"
    t.date     "financeDate"
    t.string   "cgSecOrg"
    t.string   "cgSecMgr"
    t.string   "cgOrg"
    t.string   "cgMgr"
    t.string   "opOrg"
    t.string   "cgOpMgr"
    t.string   "cgPgmDir"
    t.string   "bdMgr"
    t.string   "crmRecOwner"
    t.string   "sslMgr"
    t.integer  "divNum"
    t.string   "customer"
    t.string   "endCustomer"
    t.integer  "crn"
    t.string   "contractType"
    t.string   "opptyClass"
    t.integer  "numberOfAwards"
    t.integer  "totalPOP"
    t.string   "primeSub"
    t.float    "fy16BP"
    t.float    "fy16BPSpent"
    t.integer  "fy16BPSpentPercent"
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
    t.string   "remember_digest"
  end

end
