class AddIsBadgeToPrizes < ActiveRecord::Migration
  def change
    add_column :prizes, :is_badge, :boolean, :null => false, :default => false
  end
end
