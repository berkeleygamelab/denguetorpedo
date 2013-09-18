class AddReporterNameAndEliminatorNameAndVerifierNameToReports < ActiveRecord::Migration
  def change
    add_column :reports, :reporter_name, :string, default: ""
    add_column :reports, :eliminator_name, :string, default: ""
    add_column :reports, :verifier_name, :string, default: ""
  end
end
