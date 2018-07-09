require 'active_support/concern'

module Authorizable
  extend ActiveSupport::Concern

  def verify_admin
    redirect_to root_path unless admin?
  end

  def admin?
    current_user.admin?
  end
end
