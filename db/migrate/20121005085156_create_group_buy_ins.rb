class CreateGroupBuyIns < ActiveRecord::Migration
  def change
    create_table :group_buy_ins do |t|
      t.integer :prize_id
      t.integer :user_id
      t.integer :group_size

      t.timestamps
    end
  end
end
