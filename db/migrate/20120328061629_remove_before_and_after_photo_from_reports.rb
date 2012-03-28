class RemoveBeforeAndAfterPhotoFromReports < ActiveRecord::Migration
  def change
    remove_column :reports, :before_photo_file_name, :string
    remove_column :reports, :before_photo_content_type, :string
    remove_column :reports, :before_photo_file_size, :integer
    remove_column :reports, :before_photo_updated_at, :datetime
    
    remove_column :reports, :after_photo_file_name, :string
    remove_column :reports, :after_photo_content_type, :string
    remove_column :reports, :after_photo_file_size, :integer
    remove_column :reports, :after_photo_updated_at, :datetime
  end
end
