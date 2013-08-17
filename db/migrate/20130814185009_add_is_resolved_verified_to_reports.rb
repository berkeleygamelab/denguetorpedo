class AddIsResolvedVerifiedToReports < ActiveRecord::Migration
  def change
    add_column :reports, :is_resolved_verified, :string
  end
end
