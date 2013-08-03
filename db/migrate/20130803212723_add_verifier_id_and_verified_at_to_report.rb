class AddVerifierIdAndVerifiedAtToReport < ActiveRecord::Migration
  def change
    add_column :reports, :verifier_id, :integer
    add_column :reports, :verified_at, :timestamp
  end
end
