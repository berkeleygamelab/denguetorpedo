class Feedback < ActiveRecord::Base
  attr_accessible :email, :message, :name, :title
  validates :email, presence: true
  validates :title, presence: true
end
