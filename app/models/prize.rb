class Prize < ActiveRecord::Base
  attr_accessible :cost, :description, :expire_on, :prize_name, :redemption_directions, :stock, :user_id
  belongs_to :user
  has_many :group_buy_ins
  has_many :prize_codes
end
