module Desk
  class ApplicationController < ActionController::Base
    include Authenticatable
    include Authorizable
    protect_from_forgery with: :exception
    before_action :set_current_site
    before_action :set_sentry_context

    private

    def set_sentry_context
      Sentry.with_scope do |scope|
        scope.set_user(id: session[:user_id]) # or anything else in session
        scope.set_extras(params: params.to_unsafe_h, url: request.url)
      end
    end

    def set_current_site
      Current.site = Site.find_by(id: session[:site_id]) || NullSite.new
    end
  end
end
