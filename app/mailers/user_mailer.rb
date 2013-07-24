class UserMailer < ActionMailer::Base
  default from: "reportdengue@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Resetar a senha"
  end

  def group_buy_in_invitation(user, group)
    @user = user
    @group = group
    mail to: user.email, subject: "Group Buy In Invitation!!!"
  end

  def decline_invitation(user, buyIn)
    @user = user
    @buyIn = buyIn
    mail to: user.email, subject: "Friend has declined your Group By In Invitation"
  end

  def accept_invitation(user, buyIn)
    @user = user
    @buyIn = buyIn
    mail to: user.email, subject: "Friend has accepted your Group By In Invitation"
  end

  def item_bought(user, group)
    @user = user
    @group = group
    mail to: user.email, subject: "Group Buy In Completed!!!"
  end

end
