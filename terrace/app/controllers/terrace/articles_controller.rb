require_dependency "terrace/application_controller"

module Terrace
  class ArticlesController < ApplicationController
    layout :site_layout
    def index
      @articles = current_site.articles.published.order(created_at: :desc).page(params[:page]).per(5)
    end

    def show
      @article = current_site.articles.published.find_by!(permalink: params[:permalink])
    end

    private
      def site_layout
        "terrace/#{current_site.layout}"
      end
  end
end
