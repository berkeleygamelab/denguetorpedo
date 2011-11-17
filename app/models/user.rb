class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation, :auth_token
  has_secure_password
  has_attached_file :profile_photo, :styles => { :small => "150x150>" }

  # validates
  validates :username, :uniqueness => true
  validates :username, :format => { :with => USERNAME_REGEX, :message => "should only contain letters, numbers, or .-+_@, and have between 5-15 characters" }
  validates :password, :length => { :minimum => 4, :message => "should contain at least 4 characters" }, :if => "password_digest.nil?"

  # filters
  before_create { generate_token(:auth_token) }

  # associations
  has_many :created_reports, :class_name => "Report", :foreign_key => "reporter_id"
  has_many :claimed_reports, :class_name => "Report", :foreign_key => "claimer_id"
  has_many :eliminated_reports, :class_name => "Report", :foreign_key => "eliminator_id"
  has_many :events, :foreign_key => "creator_id"
  has_many :event_comments
  belongs_to :house

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def nearby_reports(n = 10)
    if house.nil? or house.location.nil?
      nil
    else
      lat = house.location.latitude
      lon = house.location.longitude
      dist_str = "((locations.latitude - #{lat}) * (locations.latitude - #{lat}) + (locations.longitude - #{lon}) * (locations.longitude - #{lon}))"
      Report.find_by_sql("SELECT reports.* FROM reports, locations WHERE reports.location_id = locations.id ORDER BY #{dist_str} LIMIT #{n};")
    end
  end

  def neighbors(n = 10)
    if house.nil? or house.location.nil?
      nil
    else
      lat = house.location.latitude
      lon = house.location.longitude
      dist_str = "((locations.latitude - #{lat}) * (locations.latitude - #{lat}) + (locations.longitude - #{lon}) * (locations.longitude - #{lon}))"
      User.find_by_sql("SELECT users.* FROM users, locations, houses WHERE houses.id != #{house.id} AND users.house_id = houses.id AND houses.location_id = locations.id ORDER BY #{dist_str} LIMIT #{n};")
    end
  end
  
  def reports
    results = created_reports.includes(:reporter, :claimer, :eliminator) |
      claimed_reports.includes(:reporter, :claimer, :eliminator) |
      eliminated_reports.includes(:reporter, :claimer, :eliminator)
    results.sort! do |l, r| l.updated_at <=> r.updated_at end
    results
  end
end
