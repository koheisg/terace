class Articles::HistoriesController < ApplicationController
  before_action :load_article

  def index
    @histories = @article.audits
  end

  def show
    @history = @article.audits.find(params[:id])
  end

  private
    def load_article
      @article = Article.find(params[:article_id])
    end
end
