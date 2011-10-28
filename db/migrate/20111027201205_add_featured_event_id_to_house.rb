class AddFeaturedEventIdToHouse < ActiveRecord::Migration
  def change
    add_column :houses, :featured_event_id, :integer
  end
end
