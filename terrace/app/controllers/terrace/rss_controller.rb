require_dependency "terrace/application_controller"

module Terrace
  class RssController < ApplicationController
    layout false
    def index
      @site = ::Site.find_by!(name: request.subdomain)
      @articles = site.articles.published.order(created_at: :desc).limit(10)
    end
  end
end
