class UserMailer < ActionMailer::Base
  default from: "reportdengue@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password Reset"
  end

  def group_buy_in_invitation(user)
    @user = user
    mail to: user.email, subject: "Group Buy In Invitation!!!"
  end

  def decline_invitation(user)
    @user = user
    mail to: user.email, subject: "Friend has declined your Group By In Invitation"
  end

  def accept_invitation(user)
    @user = user
    mail to: user.email, subject: "Friend has accepted your Group By In Invitation"
  end

end
