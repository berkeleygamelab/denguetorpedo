class RenameEnumeratedColumns < ActiveRecord::Migration
  def up
    rename_column :events, :category, :category_cd
    rename_column :reports, :status, :status_cd
    remove_column :feeds, :feed_type
    add_column :feeds, :feed_type_cd, :integer
  end

  def down
    rename_column :events, :category_cd, :category
    rename_column :reports, :status_cd, :status
    add_column :feeds, :feed_type, :string
    remove_column :feeds, :feed_type_cd
  end
end
