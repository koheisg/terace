class Article::Search
  include ActiveModel::Model
  attr_accessor :title, :state, :site, :user

  def query(articles)
    res = articles
    res = state_condition(res)
    res = title_condition(res)
    res = site_condition(res)
    res
  end

  def state_condition(query)
    return query.where(state: Article.states[state]) if state
    query
  end

  def title_condition(query)
    return query.where("articles.title LIKE ?", "%#{title}%") if title
    query
  end

  def site_condition(query)
    return query.where(site_id: site) if site && user.sites.exists?(site)
    query
  end
end
