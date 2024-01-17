class ApplicationController < ActionController::Base
  before_action :only_signed_in
  # rend notre methode comme un helper qu on peut dorenavant appeler dans la view
  helper_method :current_user, :user_signed_in?

  def only_signed_in
    return unless !session[:auth] || !session[:auth]['id']

    flash[:danger] = "Vous n'avez pas les droits d'accéder à cette page"
    redirect_to :new
  end

  def user_signed_in?
    current_user.nil?
  end

  def current_user
    return unless !session[:auth] || !session[:auth]['id']
    return @user if @user

    # le find_by_ + champ renvoi nil et donc ne léve pas d'exception comme le .find
    @user = User.find_by_id session[:auth]['id']
    # @user = User.find session[:auth]["id"]
  end
end
