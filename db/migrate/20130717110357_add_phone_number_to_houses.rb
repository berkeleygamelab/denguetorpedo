class AddPhoneNumberToHouses < ActiveRecord::Migration
  def change
    add_column :houses, :phone_number, :string, :default => ""
  end
end
