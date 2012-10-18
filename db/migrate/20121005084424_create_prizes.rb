class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      t.string :prize_name
      t.integer :cost
      t.integer :stock
      t.integer :user_id
      t.text :description
      t.text :redemption_directions
      t.timestamp :expire_on

      t.timestamps
    end
  end
end
