class AddRedeemedAndExpiredToPrizeCodes < ActiveRecord::Migration
  def change
    add_column :prize_codes, :redeemed, :boolean, :null => false, :default => false
    add_column :prize_codes, :expired, :boolean, :null => false, :default => false
  end
end
