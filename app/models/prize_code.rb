class PrizeCode < ActiveRecord::Base
  attr_accessible :code, :expire_by, :prize_id, :user_id
  belongs_to :user
  belongs_to :prize
end
