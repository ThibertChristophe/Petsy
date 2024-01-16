class ApplicationController < ActionController::Base
  before_action :only_signed_in
  # rend notre methode comme un helper qu on peut dorenavant appeler dans la view
  helper_method :current_user

  def only_signed_in
    return unless !session[:auth] || !session[:auth]["id"]

    flash[:danger] = "Vous n'avez pas les droits d'accéder à cette page"
    redirect_to :new
  end

  def current_user
    return unless !session[:auth] || !session[:auth]["id"]

    @user = User.find session[:auth]["id"]
  end
end
