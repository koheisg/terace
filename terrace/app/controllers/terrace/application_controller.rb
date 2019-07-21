module Terrace
  class ApplicationController < ActionController::Base
    include Authenticatable
    protect_from_forgery with: :exception
    helper_method :current_user

    before_action :set_raven_context
    private

    def set_raven_context
      Raven.extra_context(params: params.to_unsafe_h, url: request.url)
    end
  end
end
