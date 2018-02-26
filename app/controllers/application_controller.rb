class ApplicationController < ActionController::Base
  include Authenticatable
  protect_from_forgery with: :exception
  before_action :verify_user
  helper_method :current_user
end
