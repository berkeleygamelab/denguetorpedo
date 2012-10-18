class BuyIn < ActiveRecord::Base
  attr_accessible :group_buy_in_id, :user_id
  belongs_to :user
  belongs_to :group_buy_in
end
