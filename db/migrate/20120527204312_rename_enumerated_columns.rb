class RenameEnumeratedColumns < ActiveRecord::Migration
  def up
    rename_column :events, :category, :category_cd
    rename_column :reports, :status, :status_cd
    rename_column :feeds, :feed_type, :feed_type_cd
    change_column :feeds, :feed_type_cd, :integer
  end

  def down
    rename_column :events, :category_cd, :category
    rename_column :reports, :status_cd, :status
    rename_column :feeds, :feed_type_cd, :feed_type
    change_column :feeds, :feed_type_cd, :string
  end
end
