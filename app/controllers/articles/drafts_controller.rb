class Articles::DraftsController < ApplicationController
  def index
    @articles = current_user.articles.includes(:site).draft.order(created_at: :desc).page(params[:page])
    render "articles/index"
  end
end
