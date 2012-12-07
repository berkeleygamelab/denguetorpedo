class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.integer :user_id
      t.integer :prize_id

      t.timestamps
    end
  end
end
