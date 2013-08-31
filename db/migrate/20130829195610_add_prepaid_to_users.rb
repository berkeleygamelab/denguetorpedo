class AddPrepaidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :prepaid, :boolean
  end
end
