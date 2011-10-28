class AddProfilePhotoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_photo_name, :string
    add_column :users, :profile_content_type, :string
    add_column :users, :profile_file_size, :integer
    add_column :users, :profile_updated_at, :datetime
  end
end
