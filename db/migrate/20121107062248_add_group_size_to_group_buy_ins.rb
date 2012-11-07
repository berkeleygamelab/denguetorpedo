class AddGroupSizeToGroupBuyIns < ActiveRecord::Migration
  def change
    add_column :group_buy_ins, :group_size, :int
  end
end
