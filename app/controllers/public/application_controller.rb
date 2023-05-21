class Public::ApplicationController < ActionController::Base
  helper_method :current_site
  before_action :set_sentry_context

  private
    def current_site
      @site ||= ::Site.find_by!(domain: request.host)
    end

    def set_sentry_context
      Sentry.with_scope do |scope|
        scope.set_extras(params: params.to_unsafe_h, url: request.url)
      end
    end
end
