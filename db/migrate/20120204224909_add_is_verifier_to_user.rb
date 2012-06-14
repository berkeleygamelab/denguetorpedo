class AddIsVerifierToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_verifier, :boolean, :default => false

  end
end
