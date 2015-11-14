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

ActiveRecord::Schema.define(version: 20151114152128) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.string   "name"
    t.integer  "total_balance"
    t.integer  "your_balance"
    t.string   "company"
    t.integer  "roomate_id"
    t.integer  "treasurer_id"
    t.datetime "due_date"
    t.boolean  "paid",          default: false
    t.integer  "days_past_due"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "content",      null: false
    t.integer  "treasurer_id"
    t.integer  "roomate_id"
    t.integer  "post_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",        null: false
    t.string   "content",      null: false
    t.integer  "treasurer_id"
    t.integer  "roomate_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "roomates", force: :cascade do |t|
    t.string   "living_space"
    t.string   "username",                        null: false
    t.string   "email",                           null: false
    t.string   "name"
    t.boolean  "admin",           default: false
    t.string   "password_digest"
    t.string   "access_token",                    null: false
    t.integer  "treasurer_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "treasurers", force: :cascade do |t|
    t.string   "living_space",                   null: false
    t.string   "username",                       null: false
    t.string   "email",                          null: false
    t.string   "name"
    t.boolean  "admin",           default: true
    t.string   "password_digest"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "access_token"
  end

end
