require_dependency "terrace/application_controller"

module Terrace
  class RssController < ApplicationController
    layout false
    def index
      @site_name = "dreamin' blog"
      @site_description = "koheisgのブログです"
      @user = ::User.find_by!(name: request.subdomain)
      @articles = @user.articles.published.order(created_at: :desc).limit(10)
    end
  end
end
