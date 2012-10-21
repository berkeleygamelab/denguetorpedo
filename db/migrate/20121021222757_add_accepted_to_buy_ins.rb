class AddAcceptedToBuyIns < ActiveRecord::Migration
  def change
    add_column :buy_ins, :accepted, :boolean
  end
end
