class Report < ActiveRecord::Base
  has_attached_file :before_photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_attached_file :after_photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  belongs_to :reporter, :class_name => "User"
  belongs_to :claimer, :class_name => "User"
  belongs_to :eliminator, :class_name => "User"
  belongs_to :location
  has_many :feeds, :as => :target
  
  validates :reporter_id, :presence => true
  validates :location_id, :presence => true

  # callback to create the feeds
  after_save do |report|
    Feed.create_from_object(report, report.reporter_id, "reported") if report.reporter_id_changed?
    Feed.create_from_object(report, report.claimer_id, "claimed") if report.claimer_id_changed?
    Feed.create_from_object(report, report.eliminator_id, "eliminated") if report.eliminator_id_changed?
  end
  
  def neighborhood
    location.neighborhood
  end

  def strftime_updated_at
    self.updated_at.strftime("%m/%d/%Y")
  end
    
  def self.unverified_reports
    Report.where("status = 2")
  end
  
  def complete_address
    self.location.complete_address
  end
  
end
