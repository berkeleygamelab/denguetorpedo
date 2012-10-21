# == Schema Information
#
# Table name: prizes
#
#  id                    :integer          not null, primary key
#  prize_name            :string(255)
#  cost                  :integer
#  stock                 :integer
#  user_id               :integer
#  description           :text
#  redemption_directions :text
#  expire_on             :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  max_group_size        :integer
#

class Prize < ActiveRecord::Base
  attr_accessible :cost, :description, :expire_on, :prize_name, :redemption_directions, :stock, :user_id
  belongs_to :user
  has_many :group_buy_ins
  has_many :prize_codes

  validates :max_group_size, :numericality => { :greater_than => 1, :less_than => 6}
end
