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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111023030722) do

  create_table "event_comments", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_comments", ["event_id"], :name => "index_event_comments_on_event_id"
  add_index "event_comments", ["user_id"], :name => "index_event_comments_on_user_id"

  create_table "events", :force => true do |t|
    t.integer  "creator_id"
    t.text     "description"
    t.integer  "praised"
    t.integer  "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["creator_id"], :name => "index_events_on_creator_id"

  create_table "houses", :force => true do |t|
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", :force => true do |t|
    t.string   "nation"
    t.string   "state"
    t.string   "city"
    t.string   "address"
    t.string   "neighborhood"
    t.text     "report"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "auth_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "phone_number"
    t.string   "address"
    t.integer  "points"
    t.integer  "house_id"
  end

end
