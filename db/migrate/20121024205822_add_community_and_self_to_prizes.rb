class AddCommunityAndSelfToPrizes < ActiveRecord::Migration
  def change
    add_column :prizes, :community_prize, :boolean, :null => false, :default => false
    add_column :prizes, :self_prize, :boolean, :null => false, :default => false
  end
end
