class RemoveEvents < ActiveRecord::Migration
  def up
    drop_table :events
    drop_table :event_comments
  end

  def down
    create_table "event_comments" do |t|
      t.string   "content"
      t.integer  "user_id"
      t.integer  "event_id"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    add_index "event_comments", ["event_id"], :name => "index_event_comments_on_event_id"
    add_index "event_comments", ["user_id"], :name => "index_event_comments_on_user_id"

    create_table "events" do |t|
      t.integer  "creator_id"
      t.text     "description"
      t.integer  "praised"
      t.integer  "category_cd"
      t.datetime "created_at",  :null => false
      t.datetime "updated_at",  :null => false
      t.string   "title"
    end

    add_index "events", ["creator_id"], :name => "index_events_on_creator_id"
  end
end
