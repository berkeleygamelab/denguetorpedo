class AddInstitutionNameToNotices < ActiveRecord::Migration
  def change
    add_column :notices, :institution_name, :string
  end
end
