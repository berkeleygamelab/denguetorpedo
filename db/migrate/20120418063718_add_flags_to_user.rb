class AddFlagsToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_fully_registered, :boolean, :default => false
    add_column :users, :is_health_agent, :boolean, :default => false 
  end
end
