class AddClaimedAtAndEliminatedAtToReports < ActiveRecord::Migration
  def change
    add_column :reports, :claimed_at, :timestamp
    add_column :reports, :eliminated_at, :timestamp
  end
end
