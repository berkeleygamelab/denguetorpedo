class RemoveObtainedOnFromPrizeCodes < ActiveRecord::Migration
  def up
    remove_column :prize_codes, :obtained_on
  end

  def down
    add_column :prize_codes, :obtained_on, :timestamp
  end
end
