class AddExpiredToBuyIns < ActiveRecord::Migration
  def change
    add_column :buy_ins, :expired, :boolean, :null => false, :default => false
  end
end
