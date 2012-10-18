class CreatePrizeCodes < ActiveRecord::Migration
  def change
    create_table :prize_codes do |t|
      t.integer :user_id
      t.integer :prize_id
      t.timestamp :obtained_on
      t.timestamp :expire_by
      t.string :code

      t.timestamps
    end
  end
end
