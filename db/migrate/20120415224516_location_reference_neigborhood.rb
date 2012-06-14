class LocationReferenceNeigborhood < ActiveRecord::Migration
  def up
    remove_column :locations, :neighborhood
    add_column :locations, :neighborhood_id, :integer
  end

  def down
    remove_column :locations, :neighborhood_id
    add_column :locations, :neighborhood, :string
  end
end
