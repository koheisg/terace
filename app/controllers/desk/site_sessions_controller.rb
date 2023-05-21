class Desk::SiteSessionsController < Desk::ApplicationController
  def update
    session[:site_id] = Site.find_by(id: site_params[:id])&.id
    redirect_back fallback_location: root_path
  end

  def site_params
    params.require(:site).permit(:id)
  end
end
