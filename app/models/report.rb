class Report < ActiveRecord::Base
  belongs_to :reporter, :class_name => "User"
  belongs_to :claimer, :class_name => "User"
  belongs_to :eliminator, :class_name => "User"
  belongs_to :location

  validates :reporter_id, :presence => true
  validates :location_id, :presence => true
  
  def strftime_updated_at
    self.updated_at.strftime("Reported on %m/%d/%Y")
  end
    
  def self.unverified_reports
        Report.where("status = '2'")
  end
  
  def complete_address
    self.location.complete_address
  end
    
end
