class Articles::PublishedController < ApplicationController
  def index
    @articles = current_user.articles.includes(:site).published.order(created_at: :desc).page(params[:page])
    render "articles/index"
  end
end
