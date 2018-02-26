require 'active_support/concern'

module Authenticatable
  extend ActiveSupport::Concern

  def verify_user
    redirect_to new_session_path unless current_user.persisted?
  end

  def current_user
    User.find_by(id: session[:user_id]) || Logout.new
  end
end
