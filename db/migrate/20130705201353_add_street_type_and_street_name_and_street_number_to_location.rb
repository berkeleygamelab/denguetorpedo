class AddStreetTypeAndStreetNameAndStreetNumberToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :street_type, :string, :default => ""
    add_column :locations, :street_name, :string, :default => ""
    add_column :locations, :street_number, :string, :default => ""
  end
end
