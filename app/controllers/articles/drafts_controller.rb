class Articles::DraftsController < ApplicationController
  def index
    @articles = current_user.articles.draft.order(created_at: :desc).page(params[:page])
    render "articles/index"
  end
end
