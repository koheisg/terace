require 'test_helper'

class PermalinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as(users(:one))
    @permalink = permalinks(:one)
  end

  test "should get index" do
    get permalinks_url
    assert_response :success
  end

  test "should get new" do
    get new_permalink_url
    assert_response :success
  end

  test "should create permalink with article" do
    assert_difference(['Permalink.count', 'Article.count']) do
      post permalinks_url, params: { permalink: { description: @permalink.description, modified_at: @permalink.modified_at,
                                                  noindex: @permalink.noindex, path: 'new', state: @permalink.state,
                                                  permalinkable_type: 'Article',
                                                  published_at: @permalink.published_at,
                                                  site_id: @permalink.site_id,
                                                  title: @permalink.title,
                                                  permalinkable_attributes: { content: 'some' } } }
    end

    assert_redirected_to permalink_url(Permalink.last)
  end

  test "should create permalink with page" do
    assert_difference(['Permalink.count', 'Page.count']) do
      post permalinks_url, params: { permalink: { description: @permalink.description, modified_at: @permalink.modified_at,
                                                  noindex: @permalink.noindex, path: 'new', state: @permalink.state,
                                                  permalinkable_type: 'Page',
                                                  published_at: @permalink.published_at,
                                                  site_id: @permalink.site_id,
                                                  title: @permalink.title,
                                                  permalinkable_attributes: { content: 'some' } } }
    end

    assert_redirected_to permalink_url(Permalink.last)
  end

  test "should create permalink with archive" do
    category = categories(:one)

    assert_difference(['Permalink.count', 'Archive.count']) do
      post permalinks_url, params: { permalink: { description: @permalink.description, modified_at: @permalink.modified_at,
                                                  noindex: @permalink.noindex, path: 'new', state: @permalink.state,
                                                  permalinkable_type: 'Archive',
                                                  published_at: @permalink.published_at,
                                                  site_id: @permalink.site_id,
                                                  title: @permalink.title,
                                                  permalinkable_attributes: { archiveable_type: 'Category',
                                                                              archiveable_id: category.id } } }
    end

    assert_redirected_to permalink_url(Permalink.last)
  end

  test "should show permalink" do
    get permalink_url(@permalink)
    assert_response :success
  end

  test "should get edit" do
    get edit_permalink_url(@permalink)
    assert_response :success
  end

  test "should update permalink" do
    patch permalink_url(@permalink), params: { permalink: { description: @permalink.description, modified_at: @permalink.modified_at,
                                                            noindex: @permalink.noindex, path: @permalink.path,
                                                            permalinkable_id: @permalink.permalinkable_id,
                                                            permalinkable_type: @permalink.permalinkable_type,
                                                            published_at: @permalink.published_at, site_id: @permalink.site_id,
                                                            title: @permalink.title } }
    assert_redirected_to permalink_url(@permalink)
  end

  test "should destroy permalink" do
    delete permalink_url(@permalink)

    assert_redirected_to permalinks_url
  end
end
