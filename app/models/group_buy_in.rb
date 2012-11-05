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

  validates :group_size, :numericality => { :greater_than => 1, :less_than => 6 }
  
  has_many :buy_ins

  def points_per_person
    @prize = Prize.find(self.prize_id)
    @prize.cost / self.group_size
  end

  def addBuyIn(user_id)
    @buyIn = BuyIn.create({:user_id => user_id, :group_buy_in_id => self.id})
    @buyIn.send_email_invitation unless @buyIn.nil?
  end

  def hasEnoughBuyers
    number_accepted = 0
    self.buy_ins.each do |buy_in|
      number_accepted = number_accepted + 1 if buy_in.accepted
    end
    number_accepted == self.group_size
  end

  def buyItem
    self.prize.generate_prize_code(self.user_id)
  end
end
