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
  
  def reports
    created_reports + claimed_reports + eliminated_reports
  end
end
