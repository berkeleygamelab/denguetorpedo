class AddManyFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone_number, :string
    add_column :users, :address, :string
    add_column :users, :points, :integer, :default => 0, :null => false
  end
end
