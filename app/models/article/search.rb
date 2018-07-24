class Article::Search
  include ActiveModel::Model
  attr_accessor :title, :state, :site

  def query(articles)
    res = articles
    res = res.where(state: Article.states[state]) if state
    res = res.where("articles.title LIKE ?", "%#{title}%") if title
    res = res.where(site_id: site) if site
    res
  end
end
