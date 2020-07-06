require_dependency "terrace/application_controller"

module Terrace
  class PermalinksController < ApplicationController
    layout :site_layout
    def index
      @permalinks = current_site.permalinks.article_types.published.order(created_at: :desc).page(params[:page]).per(5)
    end

    def show
      @permalink = current_site.permalinks.find_by!(path: params[:permalink])
    end

    private
      def site_layout
        "terrace/#{current_site.layout}"
      end
  end
end
