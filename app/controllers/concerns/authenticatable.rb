require 'active_support/concern'

module Authenticatable
  extend ActiveSupport::Concern

  def verify_user
    redirect_to login_path unless login?
  end

  def login?
    current_user.persisted?
  end

  def current_user
    @current_user ||= if session[:user_id]
                        User.find_by(id: session[:user_id]) || Logout.new
                      else
                        Logout.new
                      end
  end
end
