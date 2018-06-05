class Articles::SearchController < ApplicationController
  def index
    @q = Article::Search.new(search_params)
    @articles = @q.query(current_user.articles.order(created_at: :desc)).page(params[:page])
  end

  def search_params
    params.permit(:title, :state)
  end
end
