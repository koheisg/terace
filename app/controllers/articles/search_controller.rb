class Articles::SearchController < ApplicationController
  def index
    @q = Article::Search.new(search_params)
    @articles = @q.query(current_user.articles.includes(:site).order(created_at: :desc)).page(params[:page])
    render 'articles/index'
  end

  def search_params
    params.permit(:title, :state)
  end
end
