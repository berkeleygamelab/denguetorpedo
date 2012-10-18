class BuyIn < ActiveRecord::Base
  attr_accessible :group_buy_in_id, :user_id
  belong_to :user
  belong_to :group_buy_in
end
