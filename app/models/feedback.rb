class Feedback < ActiveRecord::Base
  attr_accessible :email, :message, :name, :title
  validates :email, presence: true
  validates :title, presence: true
  validates :name, presence: true
  validates :message, presence: true
end
