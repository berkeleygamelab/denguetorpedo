class RemoveClaimingFromReport < ActiveRecord::Migration
  def up
    remove_column :reports, :claimed_at
    remove_column :reports, :claimer_id
  end

  def down
    add_column :reports, :claimed_at, :timestamp
    add_column :reports, :claimer_id, :integer
  end
end
