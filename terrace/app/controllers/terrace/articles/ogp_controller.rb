require_dependency "terrace/application_controller"

module Terrace
  class Articles::OgpController < ApplicationController
    layout nil
    def show
      @article = current_site.articles.published.find_by!(permalink: params[:permalink])
    end
  end
end
