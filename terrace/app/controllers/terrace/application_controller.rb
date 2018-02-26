module Terrace
  class ApplicationController < ActionController::Base
    include Authenticatable
    protect_from_forgery with: :exception
    helper_method :current_user
  end
end
