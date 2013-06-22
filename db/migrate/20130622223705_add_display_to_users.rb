class AddDisplayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :display, :string, :default => "firstmiddlelast"
  end
end
