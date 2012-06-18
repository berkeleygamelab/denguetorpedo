class CreateEventComments < ActiveRecord::Migration
  def change
    create_table :event_comments do |t|
      t.string :content
      t.references :user
      t.references :event

      t.timestamps
    end
    add_index :event_comments, :user_id
    add_index :event_comments, :event_id
  end
end
