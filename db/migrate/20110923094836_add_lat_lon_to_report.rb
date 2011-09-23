class AddLatLonToReport < ActiveRecord::Migration
  def change
    add_column :reports, :latitude, :float
    add_column :reports, :longitude, :float
    add_column :reports, :gmaps, :boolean
  end
end
