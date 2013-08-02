class AddCarrierToUsers < ActiveRecord::Migration
  def change
    add_column :users, :carrier, :string, :default => ""
  end
end
