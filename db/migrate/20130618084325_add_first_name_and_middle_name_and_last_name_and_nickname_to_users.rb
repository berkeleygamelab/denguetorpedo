class AddFirstNameAndMiddleNameAndLastNameAndNicknameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, :default => ""
    add_column :users, :middle_name, :string, :default => ""
    add_column :users, :last_name, :string, :default => ""
    add_column :users, :nickname, :string, :default => ""
  end
end
