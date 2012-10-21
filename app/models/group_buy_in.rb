class GroupBuyIn < ActiveRecord::Base
  attr_accessible :group_size, :prize_id, :user_id
  belongs_to :prize
  belongs_to :user
  has_many :invitations

  def points_per_person
    @prize = Prize.find(self.prize_id)
    @prize.cost / self.group_size
  end

  def addBuyIn(user_id)
    @buyIn = BuyIn.create({:user_id => user_id, :group_buy_in_id => self.id})
    @buyIn.send_email_invitation unless @buyIn.nil?
  end

  def hasEnoughBuyers

  end

  def buyItem

  end

end
