class AddBeforeAndAfterPhotosToReports < ActiveRecord::Migration
  def self.up
    change_table :reports do |t|
      t.has_attached_file :before_photo
      t.has_attached_file :after_photo
    end
  end
  
  def self.down
    drop_attached_file :reports, :before_photo
    drop_attached_file :reports, :after_photo
  end
end
