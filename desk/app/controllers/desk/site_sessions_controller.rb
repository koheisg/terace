require_dependency "desk/application_controller"

module Desk

class SiteSessionsController < ApplicationController
  def update
    session[:site_id] = Site.find_by(id: site_params[:id])&.id
  end

  def site_params
    params.require(:site).permit(:id)
  end
end
end