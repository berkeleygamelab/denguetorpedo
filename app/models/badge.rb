class Badge < ActiveRecord::Base
  attr_accessible :prize_id, :user_id
  belongs_to :user
  belongs_to :prize
  validates :user, :presence => true
  validates :prize, :presence => true
end
