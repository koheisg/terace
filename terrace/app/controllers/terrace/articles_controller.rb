require_dependency "terrace/application_controller"

module Terrace
  class ArticlesController < ApplicationController
    def index
      @articles = site.articles.published.order(created_at: :desc).page(params[:page]).per(5)
    end

    def show
      @article = site.articles.published.find_by!(permalink: params[:permalink])
    end

    private
      def site
        @site ||= ::Site.find_by!(domain: request.host)
      end
  end
end
