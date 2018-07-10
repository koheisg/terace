class Sites::ArticlesController < ApplicationController
  def index
    @articles = site.articles.order(created_at: :desc).page(params[:page])
    render 'articles/index'
  end

  def site
    @site = current_user.sites.find(params[:site_id])
  end
end
