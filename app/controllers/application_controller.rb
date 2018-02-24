class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :verify_user

  def verify_user
    redirect_to new_session_path unless current_user.persisted?
  end

  def current_user
    User.find(session[:user_id])
  end
end
