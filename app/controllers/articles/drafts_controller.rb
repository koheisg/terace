class Articles::DraftsController < ApplicationController
  def index
    @articles = current_user.articles.draft.order(created_at: :desc)
    render "articles/index"
  end
end
