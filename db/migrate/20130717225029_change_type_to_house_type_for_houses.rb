class ChangeTypeToHouseTypeForHouses < ActiveRecord::Migration
  def up
  	rename_column :houses, :type, :house_type
  end

  def down
  end
end
