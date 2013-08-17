class AddResolveVerifierIdAndResolveVerifiedAtToReports < ActiveRecord::Migration
  def change
    add_column :reports, :resolved_verifier_id, :integer
    add_column :reports, :resolved_verified_at, :timestamp
  end
end
