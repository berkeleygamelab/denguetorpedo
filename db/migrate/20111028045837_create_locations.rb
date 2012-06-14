class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :nation
      t.string :state
      t.string :city
      t.string :neighborhood
      t.string :address
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps

      t.timestamps
    end
  end
end
