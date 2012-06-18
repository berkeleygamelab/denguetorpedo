class UseLocation < ActiveRecord::Migration
  def up
    remove_column :reports, :nation
    remove_column :reports, :state
    remove_column :reports, :city
    remove_column :reports, :neighborhood
    remove_column :reports, :address
    remove_column :reports, :latitude
    remove_column :reports, :longitude
    remove_column :reports, :gmaps
    remove_column :users, :address
    remove_column :houses, :address

    add_column :reports, :location_id, :integer
    add_column :houses, :location_id, :integer
  end

  def down
    remove_column :reports, :location_id
    remove_column :houses, :location_id

    add_column :reports, :nation, :string
    add_column :reports, :state, :string
    add_column :reports, :city, :string
    add_column :reports, :neighborhood, :string
    add_column :reports, :address, :string
    add_column :reports, :latitude, :float
    add_column :reports, :longitude, :float
    add_column :reports, :gmaps, :string
    add_column :users, :address, :string
    add_column :houses, :address, :string
  end
end
