class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :title, :default => ""
      t.text :description, :default => ""
      t.string :location, :default => ""
      t.timestamp :date
      t.references :neighborhood
      t.references :user
      t.timestamps
    end
  end
end
