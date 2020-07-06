require_dependency "terrace/application_controller"

module Terrace
  class RssController < ApplicationController
    layout false
    def index
      @permalinks = current_site.permalinks.includes(:permalinkable).published.order(created_at: :desc).limit(10)
    end
  end
end
