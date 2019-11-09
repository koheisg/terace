require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  setup do
    user = users(:one)
    site = sites(:one)
    @article = Article.new(user: user, site: site)
  end

  test "save article" do
    assert @article.save
    assert_equal 'create', @article.audits.last.action
    assert_equal 1, @article.audits.size
    assert_equal 'create', @article.audits.last.action

    @article.title = 'a'
    assert @article.save
    assert_equal 2, @article.audits.size
    assert_equal 'update', @article.audits.last.action

    @article.title = 'b'
    assert @article.save
    assert_equal 3, @article.audits.size
    assert_equal 'update', @article.audits.last.action
  end
end
