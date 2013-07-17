class AddTypeToHouses < ActiveRecord::Migration
  def change
    add_column :houses, :type, :string, :default => "morador"
  end
end
