class Report < ActiveRecord::Base
  attr_accessible :report

  has_attached_file :before_photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :path=>':rails_root/public/system/:id.:extension'

  has_attached_file :after_photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
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

  def strftime_updated_at
    self.updated_at.strftime("%m/%d/%Y")
  end
    
  def self.unverified_reports
    Report.where(:status_cd => Report.reported)
  end
  
  def complete_address
    self.location.complete_address
  end
  
end
