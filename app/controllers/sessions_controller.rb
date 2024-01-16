class SessionsController < ApplicationController
  skip_before_action :only_signed_in, only: %i[new create]
  def new
    @user = User.new
  end

  def create
    params = user_params
    @user = User.where(username: params[:username],
      confirm: true).or(User.where(email: params[:username],
        confirm: true)).first
    if @user && @user.authenticate(params[:password])
      session[:auth] = {id: @user.id}
      redirect_to profile_path, message: "Connexion reussie"
    else
      redirect_to new_session_path, message: "Identifiant incorrect"
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user)
  end
end
