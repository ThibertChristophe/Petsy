class PasswordsController < ApplicationController
  # on desactive le fait de devoir etre login
  skip_before_action :only_signed_in
  # on active le fait que ce n'est accessible que si on est logoff
  before_action :only_signed_out

  def new; end

  # Permet de lancer une demande de recuperation de mot de passe
  def create
    user_params = params.require(:user).permit(:email)
    @user = User.find_by_email user_params[:email]
    if @user
      # on regenere un token de recovery
      @user.regenerate_recover_password
      UserMailer.password(@user).deliver_now
      redirect_to new_session_path, success: 'Email envoyé'
    else
      redirect_to new_password_path, danger: 'Aucun email ne correspond'
    end
  end

  def update; end

  def edit; end
end
