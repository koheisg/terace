class Public::PermalinksController < Public::ApplicationController
  layout :site_layout
  def show
    @permalink = current_site.permalinks.find_by!(path: params[:permalink] || '')
  end

  private
    def site_layout
      "public/#{current_site.layout}"
    end
end
