class GroupBuyIn < ActiveRecord::Base
  attr_accessible :group_size, :prize_id, :user_id
  belongs_to :prize
  belongs_to :user
end
