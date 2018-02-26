require_dependency "terrace/application_controller"

module Terrace
  class ArticlesController < ApplicationController
    def index
      @user = ::User.find_by!(name: request.subdomain)
      @articles = @user.articles.published
    end

    def show
      @user = ::User.find_by!(name: request.subdomain)
      @article = ::Article.published.find_by!(permalink: params[:permalink])
    end
  end
end
