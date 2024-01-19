class ApplicationController < ActionController::Base
  # rend nos methode comme un helper qu on peut dorenavant appeler partout ailleurs
  helper_method :current_user, :user_signed_in?

  # on va considerer au depart que toute la web app est accessible si on est loggé
  # on ira mettre du skip_before_action dans les autre controller ne necessitant pas d'etre loggé
  before_action :only_signed_in

  # Redirige vers la page d'inscription si on est pas loggé
  def only_signed_in
    return if user_signed_in?

    flash[:danger] = "Vous n'avez pas les droits d'accéder à cette page"
    redirect_to new_session_path
  end

  # va nous servir de savoir si le user est signed
  def user_signed_in?
    !current_user.nil?
  end

  # Renvoi le user loggé sinon nil
  def current_user
    return nil if !session[:auth] || !session[:auth]['id']
    return @user if @user

    # le find_by_ + champ renvoi nil et donc ne léve pas d'exception comme le .find
    @user = User.find_by_id session[:auth]['id']
    # @user = User.find session[:auth]["id"]
  end
end
