class AddBeforeAndAfterPhotoToReports < ActiveRecord::Migration
  def change
    add_column :reports, :before_photo_file_name, :string
    add_column :reports, :before_photo_content_type, :string
    add_column :reports, :before_photo_file_size, :integer
    add_column :reports, :before_photo_updated_at, :datetime
    
    add_column :reports, :after_photo_file_name, :string
    add_column :reports, :after_photo_content_type, :string
    add_column :reports, :after_photo_file_size, :integer
    add_column :reports, :after_photo_updated_at, :datetime
  end
end
