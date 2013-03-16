class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :phone
      t.text :text
      t.string :board

      t.timestamps
    end
  end
end
