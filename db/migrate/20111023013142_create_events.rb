class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :creator
      t.text :description
      t.integer :praised
      t.integer :category

      t.timestamps
    end
    add_index :events, :creator_id
  end
end
