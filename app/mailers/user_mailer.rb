class UserMailer < ApplicationMailer
  def confirm(user)
    @user = user
    mail to: user.email, subject: 'Confirmation inscription'
  end

  def password(user)
    @user = user
    mail to: user.email, subject: 'Recupération de mot de passe'
  end
end
