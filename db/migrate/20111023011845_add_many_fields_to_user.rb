class AddManyFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone_number, :integer
    add_column :users, :address, :string
    add_column :users, :points, :integer, :default => 0
  end
end
