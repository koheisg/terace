class Fishur::RssController < Fishur::ApplicationController
  def index
    @permalinks = current_site.permalinks.includes(:permalinkable).article_types.published.order(created_at: :desc).limit(10)
  end
end
