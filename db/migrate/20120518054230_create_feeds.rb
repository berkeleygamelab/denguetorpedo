class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :target_type
      t.integer :target_id
      t.string :feed_type

      t.timestamps
    end
  end
end
