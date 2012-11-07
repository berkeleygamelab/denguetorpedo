# == Schema Information
#
# Table name: buy_ins
#
#  id              :integer          not null, primary key
#  group_buy_in_id :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  accepted        :boolean
#  expired         :boolean          default(FALSE), not null
#

class BuyIn < ActiveRecord::Base
  attr_accessible :group_buy_in_id, :user_id, :accepted
  belongs_to :user
  belongs_to :group_buy_in

  def send_email_invitation
    UserMailer.group_buy_in_inviation(self.user, self.group_buy_in).deliver
  end

  #Called when user clicks on "decline" link
  def send_decline_email
    UserMailer.decline_invitation(self.group_buy_in.user, self).deliver
  end

  #Called when user clicks on "accept" link
  def send_accept_email
    if self.user.joinGroupBuyIn(self.group_buy_in_id)
      self.accepted = true
      if self.group_buy_in.hasEnoughBuyers
        self.group_buy_in.buyItem
        UserMailer.item_bought(self.group_buy_in.user, self.group_buy_in).deliver
      else
        UserMailer.accept_invitation(self.group_buy_in.user, self).deliver
      end
    end
  end

  def self.set_invites_expired
    BuyIn.all.each do |buyIn|
      buyIn.expired = true if 1.days.ago > buyIn.created_at
    end
  end

end
