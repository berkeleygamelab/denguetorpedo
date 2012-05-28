class RemoveBeforeAndAfterPhotoFromReports < ActiveRecord::Migration
  def up
    remove_column :reports, :before_photo_file_name
    remove_column :reports, :before_photo_content_type
    remove_column :reports, :before_photo_file_size
    remove_column :reports, :before_photo_updated_at
    
    remove_column :reports, :after_photo_file_name
    remove_column :reports, :after_photo_content_type
    remove_column :reports, :after_photo_file_size
    remove_column :reports, :after_photo_updated_at
  end
  
  def down
    add_column :reports, :before_photo_file_name, :string
    add_column :reports, :before_photo_content_type, :string
    add_column :reports, :before_photo_file_size, :integer
    add_column :reports, :before_photo_updated_at, :datetime
    add
    add_column :reports, :after_photo_file_name, :string
    add_column :reports, :after_photo_content_type, :string
    add_column :reports, :after_photo_file_size, :integer
    add_column :reports, :after_photo_updated_at, :datetime
  end
end
