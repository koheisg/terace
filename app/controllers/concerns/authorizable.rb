require 'active_support/concern'

module Authorizable
  extend ActiveSupport::Concern

  def admin?
    current_user.admin?
  end
end
