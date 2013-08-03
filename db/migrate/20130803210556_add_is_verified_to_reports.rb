class AddIsVerifiedToReports < ActiveRecord::Migration
  def change
    add_column :reports, :isVerified, :string
  end
end
