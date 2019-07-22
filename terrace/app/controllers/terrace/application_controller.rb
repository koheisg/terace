module Terrace
  class ApplicationController < ActionController::Base
    include Authenticatable
    protect_from_forgery with: :exception
    helper_method :current_user, :current_site

    before_action :set_raven_context

    private
      def current_site
        @site ||= ::Site.find_by!(domain: request.host)
      end

      def set_raven_context
        Raven.extra_context(params: params.to_unsafe_h, url: request.url)
      end
  end
end
