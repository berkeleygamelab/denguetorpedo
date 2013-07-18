class AddUserToHouses < ActiveRecord::Migration
  def change
  	add_column :houses, :user_id, :integer
  end
end
