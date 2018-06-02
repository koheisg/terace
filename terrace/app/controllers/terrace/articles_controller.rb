require_dependency "terrace/application_controller"

module Terrace
  class ArticlesController < ApplicationController
    def index
      @user = ::User.find_by!(name: request.subdomain)
      @articles = @user.articles.published.order(created_at: :desc).page(params[:page]).per(5)
    end

    def show
      @user = ::User.find_by!(name: request.subdomain)
      @article = ::Article.published.find_by!(permalink: params[:permalink])
    end
  end
end
