module Terrace
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_site

    before_action :set_sentry_context

    private
      def current_site
        @site ||= ::Site.find_by!(domain: request.host)
      end

      def set_sentry_context
        Sentry.with_scope do |scope|
          scope.set_user(id: session[:user_id]) # or anything else in session
          scope.set_extras(params: params.to_unsafe_h, url: request.url)
        end
      end
  end
end
