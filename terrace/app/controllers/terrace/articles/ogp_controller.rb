require_dependency "terrace/application_controller"

module Terrace
  class Articles::OgpController < ApplicationController
    layout nil

    def show
      @article = current_site.articles.published.find_by!(permalink: params[:permalink])
      send_data(@article.ogp_png,
                filename: params[:permalink] + '.png',
                type: 'image/png',
                disposition: 'inline')
    end
  end
end
