class Articles::SearchController < ApplicationController
  def index
    @sites = current_user.sites
    @q = Article::Search.new(search_params)
    @q.user = current_user
    @articles = @q.query(current_user.articles.includes(:site).order(created_at: :desc)).page(params[:page])
    render 'articles/index'
  end

  private

  def search_params
    params.permit(:title, :state, :site)
  end
end
