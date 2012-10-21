# == Schema Information
#
# Table name: group_buy_ins
#
#  id         :integer          not null, primary key
#  prize_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GroupBuyIn < ActiveRecord::Base
  attr_accessible :prize_id, :user_id
  belongs_to :prize
  belongs_to :user
  
  validates :user, :presence => true
  validates :prize, :presence => true
end
