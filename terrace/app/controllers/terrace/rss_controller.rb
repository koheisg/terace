require_dependency "terrace/application_controller"

module Terrace
  class RssController < ApplicationController
    layout false
    def index
      @articles = current_site.articles.published.order(created_at: :desc).limit(10)
    end
  end
end
