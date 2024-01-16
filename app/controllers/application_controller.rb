class ApplicationController < ActionController::Base
  before_action :only_signed_in

  def only_signed_in
    return unless !session[:auth] || !session[:auth]['id']

    flash[:danger] = "Vous n'avez pas les droits d'accéder à cette page"
    redirect_to :new
  end
end
