class MoveGroupSizeToPrize < ActiveRecord::Migration
  def up
    add_column :prizes, :max_group_size, :integer
    remove_column :group_buy_ins, :group_size
  end

  def down
  end
end
