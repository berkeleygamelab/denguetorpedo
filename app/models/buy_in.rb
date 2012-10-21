# == Schema Information
#
# Table name: buy_ins
#
#  id              :integer          not null, primary key
#  group_buy_in_id :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class BuyIn < ActiveRecord::Base
  attr_accessible :group_buy_in_id, :user_id
  belongs_to :user
  belongs_to :group_buy_in
end
