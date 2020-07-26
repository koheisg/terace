require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  setup do
    @article = Article.new
  end

  test 'valid when permalink is nil and state is shipped' do
    assert @article.valid?
  end

  test '#save should return true' do
    assert @article.save
  end

  test "audits when save article" do
    assert @article.save
    assert_equal 'create', @article.audits.last.action
    assert_equal 1, @article.audits.size
    assert_equal 'create', @article.audits.last.action

    assert @article.save
    assert_equal 2, @article.audits.size
    assert_equal 'update', @article.audits.last.action

    assert @article.save
    assert_equal 3, @article.audits.size
    assert_equal 'update', @article.audits.last.action
  end
end
