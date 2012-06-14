class AddClaimerIdToReport < ActiveRecord::Migration
  def change
    add_column :reports, :claimer_id, :integer
  end
end
