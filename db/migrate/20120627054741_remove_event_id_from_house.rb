class RemoveEventIdFromHouse < ActiveRecord::Migration
  def up
    remove_column :houses, :featured_event_id
  end

  def down
    add_column :houses, :featured_event_id, :integer
  end
end
