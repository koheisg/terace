class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :verify_user

  def verify_user
    redirect_to new_session_path unless current_user.persisted?
  end

  helper_method :current_user

  def current_user
    User.find_by(id: session[:user_id]) || Logout.new
  end
end
