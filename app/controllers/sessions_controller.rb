class SessionsController < ApplicationController
  # Controller qui permet de se connecter et donc de creer une session utilisateur

  # on defini les actions qui ne necessite pas d'etre loggé
  # Pas besoin d'etre loggé pour se creer une session, c'est la partie oú on va avoir le formulaire de "Se connecter"
  skip_before_action :only_signed_in, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    params = user_params
    @user = User.where(username: params[:username],
                       confirm: true).or(User.where(email: params[:username],
                                                    confirm: true)).first
    # if @user && @user.authenticate(params[:password])
    if @user&.authenticate(params[:password])
      session[:auth] = { id: @user.id }
      redirect_to profile_path, message: 'Connexion reussie'
    else
      redirect_to new_session_path, message: 'Identifiant incorrect'
    end
  end

  def destroy
    session.destroy
    redirect_to new_session_path, success: 'Vous êtes déconnecté'
  end

  private

  def user_params
    params.require(:user)
  end
end
