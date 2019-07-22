require_dependency "terrace/application_controller"

module Terrace
  class ArticlesController < ApplicationController
    def index
      @articles = current_site.articles.published.order(created_at: :desc).page(params[:page]).per(5)
    end

    def show
      @article = current_site.articles.published.find_by!(permalink: params[:permalink])
    end
  end
end
