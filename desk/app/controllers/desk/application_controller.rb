module Desk
  class ApplicationController < ActionController::Base
    include Authenticatable
    include Authorizable
    protect_from_forgery with: :exception
    before_action :set_current_site
    before_action :set_raven_context

    private

    def set_raven_context
      Raven.user_context(id: session[:user_id]) # or anything else in session
      Raven.extra_context(params: params.to_unsafe_h, url: request.url)
    end

    def set_current_site
      Current.site = Site.find_by(id: session[:site_id]) || NullSite.new
    end
  end
end