require_dependency "terrace/application_controller"

module Terrace
  class PagesController < ApplicationController
    def index
      page = params[:page].gsub('page', '')
      redirect_to(root_path(page: page))
    end
  end
end
