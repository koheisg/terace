require_dependency "terrace/application_controller"

module Terrace
  class PermalinksController < ApplicationController
    layout :site_layout
    def show
      @permalink = current_site.permalinks.find_by!(path: params[:permalink])
    end

    private
      def site_layout
        "terrace/#{current_site.layout}"
      end
  end
end
