class User < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation, :auth_token
  has_secure_password

  # validates
  validates :username, :uniqueness => true
  validates :username, :format => { :with => USERNAME_REGEX, :message => "should only contain letters, numbers, or .-+_@, and have between 5-15 characters" }
  validates :password, :length => { :minimum => 4, :message => "should contain at least 4 characters" }

  # filters
  before_create { generate_token(:auth_token) }

  has_many :reports


  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
