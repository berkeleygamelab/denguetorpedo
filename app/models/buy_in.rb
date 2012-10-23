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
#

class BuyIn < ActiveRecord::Base
  attr_accessible :group_buy_in_id, :user_id, :accepted
  belongs_to :user
  belongs_to :group_buy_in

  def send_email_invitation
    UserMailer.group_buy_in_inviation(self.user).deliver
  end

  def send_decline_email
    UserMailer.decline_invitation(self.group_buy_in.user).deliver
  end

  def send_accept_email
    self.accepted = true
    if self.group_buy_in.hasEnoughBuyers
      self.group_buy_in.buyItem
    else
      UserMailer.accept_invitation(self.group_buy_in.user).deliver
    end
  end

end
