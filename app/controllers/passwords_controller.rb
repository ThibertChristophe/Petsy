class PasswordsController < ApplicationController
  # on desactive le fait de devoir etre login
  skip_before_action :only_signed_in
  # on active le fait que ce n'est accessible que si on est logoff
  before_action :only_signed_out

  def new
    @user = User.new
  end

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
      flash[:danger] = 'Email invalide'
      redirect_to new_password_path
    end
  end

  def update
    user_params = params.require(:user).permit(:password, :password_confirmation, :recover_password)
    @user = User.find params[:id]
    if @user.recover_password == user_params[:recover_password]
      if @user.update user_params
        @user.recover_password = nil
        @user.save
        session[:auth] = { id: @user.id }
        flash[:success] = 'Mot de passe modifié'
        redirect_to profile_path
      else
        flash[:danger] = 'Erreur de password'
        render :edit
      end
    else
      flash[:danger] = 'Token invalide'
      render :edit
    end
  end

  def edit
    @user = User.find params[:id]
    return if @user.recover_password == params[:token]

    redirect_to new_password_path, danger: 'Invalide'
  end
end
