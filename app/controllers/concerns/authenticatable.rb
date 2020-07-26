require 'active_support/concern'

module Authenticatable
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
    before_action :verify_user
    helper_method :login?, :admin?

    def verify_user
      redirect_to login_path unless login?
    end

    def login?
      Current.user.persisted?
    end

    def set_current_user
      Current.user ||= if session[:user_id]
                         User.find_by(id: session[:user_id]) || Logout.new
                       else
                         Logout.new
                       end
    end
  end
end
