class AddWallToPost < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.references :wall, :polymorphic => true
    end
  end
end
