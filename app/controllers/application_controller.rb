class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :log_everything

  def authenticate_user!
    redirect_to new_session_path, alert: 'Please sign in' unless user_signed_in?
  end

  def user_signed_in?
    session[:user_id].present?
  end

  def current_user
    User.find session[:user_id] if user_signed_in?
  end

  # make method accessible in any view file
  helper_method :current_user
  helper_method :user_signed_in?

  private

  def log_everything
    if Rails.env == 'development'
      logger.debug %{#{'Action Started'.red}
        #{"Params:".blue} #{params.inspect}
  }
    end
  end
end
