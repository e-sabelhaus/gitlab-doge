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

ActiveRecord::Schema.define(version: 20150219193725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "builds", force: true do |t|
    t.text     "violations"
    t.integer  "repo_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "uuid",             null: false
    t.integer  "merge_request_id"
    t.string   "commit_sha"
  end

  add_index "builds", ["merge_request_id", "commit_sha"], name: "index_builds_on_merge_request_id_and_commit_sha", unique: true, using: :btree
  add_index "builds", ["repo_id"], name: "index_builds_on_repo_id", using: :btree
  add_index "builds", ["uuid"], name: "index_builds_on_uuid", unique: true, using: :btree

  create_table "memberships", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "repo_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["repo_id", "user_id"], name: "index_memberships_on_repo_id_and_user_id", using: :btree

  create_table "repos", force: true do |t|
    t.integer  "gitlab_id",                        null: false
    t.boolean  "active",           default: false, null: false
    t.integer  "hook_id"
    t.string   "full_gitlab_name",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "private"
  end

  add_index "repos", ["active"], name: "index_repos_on_active", using: :btree
  add_index "repos", ["gitlab_id"], name: "index_repos_on_gitlab_id", using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "gitlab_username",                  null: false
    t.string   "remember_token",                   null: false
    t.boolean  "refreshing_repos", default: false
    t.string   "email_address"
    t.string   "dn"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
