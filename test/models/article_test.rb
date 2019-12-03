require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  setup do
    user = users(:one)
    site = sites(:one)
    @article = Article.new(user: user, site: site)
  end

  test 'invalid when permalink is nil and state is shipped' do
    @article.permalink = nil
    @article.state = :shipped
    assert @article.invalid?
    assert_equal ["Permalink can't be blank"], @article.errors.full_messages
  end

  test 'valid when permalink is nil and state is shipped' do
    @article.permalink = nil
    @article.state = :draft
    assert @article.valid?
  end

  test 'published_at and modified_at when save article as draft' do
    @article.state = :draft
    assert @article.save
    assert_nil @article.published_at
    assert_nil @article.modified_at
  end

  test 'published_at and modified_at when save article as shipped' do
    @article.permalink = 'test'
    @article.state = :shipped
    assert @article.save
    assert @article.published_at
    assert @article.modified_at
  end

  test 'published_at and modified_at when update article from draft to draft' do
    @article.state = :draft
    @article.save
    @article.permalink = 'test'
    assert @article.save

    assert_nil @article.published_at
    assert_nil @article.modified_at
  end

  test 'published_at and modified_at when update article from draft to shipped' do
    @article.state = :draft
    assert @article.save
    @article.permalink = 'test'
    assert @article.shipped!

    assert @article.published_at
    assert @article.modified_at
  end

  test 'published_at and modified_at when update article from shipped to shipped' do
    @article.state = :shipped
    @article.permalink = 'test'
    assert @article.save
    assert @article.published_at
    assert @article.modified_at

    assert_changes ->{ @article.modified_at } do
      @article.permalink = 'test1'
      assert @article.save
    end

    assert_no_changes ->{ @article.published_at } do
      @article.permalink = 'test2'
      assert @article.save
    end
  end

  test "audits when save article" do
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
