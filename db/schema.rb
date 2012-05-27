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

ActiveRecord::Schema.define(:version => 20120527204312) do

  create_table "event_comments", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "event_comments", ["event_id"], :name => "index_event_comments_on_event_id"
  add_index "event_comments", ["user_id"], :name => "index_event_comments_on_user_id"

  create_table "events", :force => true do |t|
    t.integer  "creator_id"
    t.text     "description"
    t.integer  "praised"
    t.integer  "category_cd"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "title"
  end

  add_index "events", ["creator_id"], :name => "index_events_on_creator_id"

  create_table "feeds", :force => true do |t|
    t.string   "target_type"
    t.integer  "target_id"
    t.integer  "feed_type_cd", :limit => 255
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "user_id"
  end

  create_table "houses", :force => true do |t|
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "name"
    t.integer  "featured_event_id"
    t.integer  "location_id"
  end

  create_table "locations", :force => true do |t|
    t.string   "nation"
    t.string   "state"
    t.string   "city"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "formatted_address"
    t.integer  "neighborhood_id"
  end

  create_table "neighborhoods", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "coordinator_id"
  end

  create_table "reports", :force => true do |t|
    t.text     "report"
    t.integer  "reporter_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "status_cd"
    t.integer  "eliminator_id"
    t.integer  "claimer_id"
    t.integer  "location_id"
    t.string   "before_photo_file_name"
    t.string   "before_photo_content_type"
    t.integer  "before_photo_file_size"
    t.datetime "before_photo_updated_at"
    t.string   "after_photo_file_name"
    t.string   "after_photo_content_type"
    t.integer  "after_photo_file_size"
    t.datetime "after_photo_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "auth_token"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "email"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "phone_number"
    t.integer  "points",                     :default => 0,     :null => false
    t.integer  "house_id"
    t.string   "profile_photo_file_name"
    t.string   "profile_photo_content_type"
    t.integer  "profile_photo_file_size"
    t.datetime "profile_photo_updated_at"
    t.boolean  "is_verifier",                :default => false
    t.boolean  "is_fully_registered",        :default => false
    t.boolean  "is_health_agent",            :default => false
  end

end
