class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def user_signed_in?
    session[:user_id].present?
  end

  def current_user
    User.find session[:user_id] if user_signed_in?
  end
  # make method accessible in any view file
  helper_method :current_user
  helper_method :user_signed_in?
end
