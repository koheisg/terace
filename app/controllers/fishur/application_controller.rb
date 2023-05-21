module Fishur
  class ApplicationController < ActionController::API
    # protect_from_forgery with: :exception
    helper_method :current_site
    def current_site
      @site ||= ::Site.find_by!(domain: request.host)
    end
  end
end
