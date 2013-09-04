class AddSmsToReports < ActiveRecord::Migration
  def change
    add_column :reports, :sms, :boolean, default: false
  end
end
