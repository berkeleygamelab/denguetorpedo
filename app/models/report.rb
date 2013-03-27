# == Schema Information
#
# Table name: reports
#
#  id                        :integer          not null, primary key
#  report                    :text
#  reporter_id               :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  status_cd                 :integer
#  eliminator_id             :integer
#  claimer_id                :integer
#  location_id               :integer
#  before_photo_file_name    :string(255)
#  before_photo_content_type :string(255)
#  before_photo_file_size    :integer
#  before_photo_updated_at   :datetime
#  after_photo_file_name     :string(255)
#  after_photo_content_type  :string(255)
#  after_photo_file_size     :integer
#  after_photo_updated_at    :datetime
#

class Report < ActiveRecord::Base
  attr_accessible :report

  has_attached_file :before_photo, :styles => {:medium => "300x300>", :thumb => "100x100>"}, :default_url => 'default_images/report1.jpg', :storage => STORAGE, :s3_credentials => S3_CREDENTIALS
  has_attached_file :after_photo, :styles => {:medium => "300x300>", :thumb => "100x100>"}, :default_url => 'default_images/report1.2.jpg', :storage => STORAGE, :s3_credentials => S3_CREDENTIALS
    
  belongs_to :reporter, :class_name => "User"
  belongs_to :claimer, :class_name => "User"
  belongs_to :eliminator, :class_name => "User"
  belongs_to :location
  has_many :feeds, :as => :target
  
  validates :reporter_id, :presence => true
  validates :location_id, :presence => true
  validates :status, :presence => true

  as_enum :status, [:reported, :claimed, :eliminated]

  def self.create_from_user(report_content, params)
    create(:report => report_content) do |r|
      r.reporter_id = params[:reporter].id
      r.location_id = params[:location].id
      r.status = params[:status]

      # optional parameters
      r.claimer_id = params[:claimer] && params[:claimer].id
      r.eliminator_id = params[:eliminator] && params[:eliminator].id
      if params[:before_photo]
        r.before_photo = params[:before_photo]
      end
      if params[:after_photo]
        r.after_photo = params[:after_photo]
      end
    end
  end

  # callback to create the feeds
  after_save do |report|
    Feed.create_from_object(report, report.reporter_id, :reported) if report.reporter_id_changed?
    Feed.create_from_object(report, report.claimer_id, :claimed) if report.claimer_id_changed?
    Feed.create_from_object(report, report.eliminator_id, :eliminated) if report.eliminator_id_changed?
  end
  
  def neighborhood
    location.neighborhood
  end
  
  def strftime_with(type)
    if type == :created_at
      self.created_at.strftime("%Y/%m/%d")
    elsif type == :updated_at
      self.updated_at.strftime("%Y/%m/%d")
    elsif type == :claimed_at
      self.claimed_at != nil ? self.claimed_at.strftime("%Y/%m/%d") : "" 
    elsif type == :eliminated_at
      self.eliminated_at != nil ? self.eliminated_at.strftime("%Y/%m/%d") : ""
    else 
      ""
    end
  end  
    
  def self.unverified_reports
    Report.where(:status_cd => Report.reported)
  end
  
  def complete_address
    self.location.complete_address
  end
  
  def self.within_bounds(bounds)
    
    reports_in_bounds = []
    for report in Report.all(:order => "created_at desc")
      if self.inBounds(report.location, bounds)
        reports_in_bounds.append(report)
        puts report.inspect + ' added'
      end 
    end
    return reports_in_bounds
  end
  def self.inBounds(location, bounds)
    swlng = bounds[1]
    swlat = bounds[0]
    nelng = bounds[3]
    nelat = bounds[2]
    sw = Geokit::LatLng.new(swlat, swlng)
    ne = Geokit::LatLng.new(nelat, nelng)
    calculated_bounds = Geokit::Bounds.new(sw,ne)
    point = Geokit::LatLng.new(location.latitude, location.longitude)
    return calculated_bounds.contains?(point)
  end
end
