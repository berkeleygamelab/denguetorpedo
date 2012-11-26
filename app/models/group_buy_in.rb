# == Schema Information
#
# Table name: group_buy_ins
#
#  id         :integer          not null, primary key
#  prize_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_size :integer
#  expired    :boolean          default(FALSE), not null
#

class GroupBuyIn < ActiveRecord::Base
  attr_accessible :prize_id, :user_id, :group_size
  belongs_to :prize
  belongs_to :user
  validates :user, :presence => true
  validates :prize, :presence => true

  validates :group_size, :numericality => { :greater_than => 1, :less_than => 6 }
  
  has_many :buy_ins

  def points_per_person
    @prize = Prize.find(self.prize_id)
    @prize.cost / self.group_size
  end

  def add_buy_in(user_id)
    unless self.too_many_buy_ins
      @buyIn = BuyIn.create({:user_id => user_id, :group_buy_in_id => self.id})
      @buyIn.send_email_invitation unless @buyIn.nil?
      return true
    end
    return false
  end

  def has_enough_buyers
    number_accepted = 0
    self.buy_ins.each do |buy_in|
      number_accepted = number_accepted + 1 if buy_in.accepted
    end
    number_accepted == self.group_size
  end

  def buy_item
    self.user.buy_prize(self.prize_id)
  end

  def too_many_buy_ins
    active_buy_ins = 0
    self.buy_ins.each do |buy_in|
      active_buy_ins = active_buy_ins + 1 if (buy_in.accepted or not buy_in.expired)
    end
    active_buy_ins >= self.group_size
  end
end
