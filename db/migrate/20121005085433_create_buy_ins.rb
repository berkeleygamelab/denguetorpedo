class CreateBuyIns < ActiveRecord::Migration
  def change
    create_table :buy_ins do |t|
      t.integer :group_buy_in_id
      t.integer :user_id

      t.timestamps
    end
  end
end
