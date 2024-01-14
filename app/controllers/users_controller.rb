class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = 'Utilisateur créé avec succès'
    #      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Permet de valider les parametres
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
