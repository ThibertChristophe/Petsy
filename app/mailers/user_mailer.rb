class UserMailer < ApplicationMailer
  def confirm(user)
    @user = user
    mail to: user.email, subject: 'Confirmation inscription'
  end
end
