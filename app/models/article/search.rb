class Article::Search
  include ActiveModel::Model
  attr_accessor :title, :state

  def query(articles)
    res = articles
    res = res.where(state: Article.states[state]) if state
    res = res.where("articles.title LIKE ?", "%#{title}%") if title
    res
  end
end
