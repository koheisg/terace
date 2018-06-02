class Article::Search
  include ActiveModel::Model
  attr_accessor :title

  def query(articles)
    articles.where("articles.title LIKE ?", "%#{title}%")
  end
end
