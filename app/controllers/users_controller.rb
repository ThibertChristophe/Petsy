class UsersController < ApplicationController
  # Controller qui permet de se créer un compte user et de confirmer notre compte via la reception d'un email

  before_action :set_user, only: %i[confirm]

  # on defini les actions qui ne necessite pas d'etre loggé
  # Pas besoin d'etre loggé pour se creer un nouveau user ou confirmer notre inscription
  skip_before_action :only_signed_in, only: %i[new create confirm]

  # Il faut etre log off pour acceder a new, create et confirm
  before_action :only_signed_out, only: %i[new create confirm]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = 'Utilisateur créé avec succès, veuillez vérifier vos emails'
      # envoi le mail de confirmation
      UserMailer.confirm(@user).deliver_now
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def confirm
    # si le parametre token dans l url correspond bien au token dans la db pour ce user
    # ps : on a recup l id avec le before_action qui set le @user
    if @user.confirmation_token == params[:token]
      @user.confirm = true
      @user.confirmation_token = nil
      @user.save validate: false
      session[:auth] = { id: @user.id }
      flash[:success] = 'Utilisateur confirmé, vous pouvez vous connecter'
      @result = 'Utilisateur confirmé, vous pouvez vous connecter'
      redirect_to profile_path
    else
      flash[:danger] = 'Validation impossible'
      @result = 'Validation impossible'
    end
  end

  def edit
    @user = User.find session[:auth]['id']
  end

  private

  # Permet d eviter de repeter cette ligne, on va l utiliser dans le before_action
  # Recup du param id dans url
  def set_user
    @user = User.find params[:id]
  end

  # Permet de valider les parametres
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
