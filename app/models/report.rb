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
#  location_id               :integer
#  before_photo_file_name    :string(255)
#  before_photo_content_type :string(255)
#  before_photo_file_size    :integer
#  before_photo_updated_at   :datetime
#  after_photo_file_name     :string(255)
#  after_photo_content_type  :string(255)
#  after_photo_file_size     :integer
#  after_photo_updated_at    :datetime
#  elimination_type          :string
#  elimination_method        :string


class Report < ActiveRecord::Base
  attr_accessible :report, :elimination_type, :elimination_method, :verifier_id

  has_attached_file :before_photo, :styles => {:medium => "150x150>", :thumb => "100x100>"}, :default_url => 'default_images/report_before_photo.png'#, :storage => STORAGE, :s3_credentials => S3_CREDENTIALS
  has_attached_file :after_photo, :styles => {:medium => "150x150>", :thumb => "100x100>"}, :default_url => 'default_images/report_after_photo.png'#, :storage => STORAGE, :s3_credentials => S3_CREDENTIALS
    
  belongs_to :reporter, :class_name => "User"
  belongs_to :eliminator, :class_name => "User"
  belongs_to :location
  has_many :feeds, :as => :target
  
  belongs_to :verifier, :class_name => "User"

  validates :reporter_id, :presence => true
  validates :location_id, :presence => true
  validates :status, :presence => true

  validates :before_photo, :presence => true

  as_enum :status, [:reported, :eliminated]

  def self.create_from_user(report_content, params)
    create(:report => report_content) do |r|
      r.reporter_id = params[:reporter] && params[:reporter].id
      r.location_id = params[:location] && params[:location].id
      r.status = params[:status]

      # optional parameters
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
    Feed.create_from_object(report, report.eliminator_id, :eliminated) if report.eliminator_id_changed?
  end
  
  def neighborhood
    location.neighborhood
  end
  
  def strftime_with(type)
    if type == :created_at
      self.created_at.strftime("%d/%m/%Y")
    elsif type == :updated_at
      self.updated_at.strftime("%d/%m/%Y")
    elsif type == :eliminated_at
      self.eliminated_at != nil ? self.eliminated_at.strftime("%d/%m/%Y") : ""
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
