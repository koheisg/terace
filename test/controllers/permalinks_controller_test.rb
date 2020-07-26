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

  test "should create permalink" do
    assert_difference('Permalink.count') do
      post permalinks_url, params: { permalink: { description: @permalink.description, modified_at: @permalink.modified_at,
                                                  noindex: @permalink.noindex, path: 'new', state: @permalink.state,
                                                  permalinkable_id: @permalink.permalinkable_id,
                                                  permalinkable_type: @permalink.permalinkable_type, published_at: @permalink.published_at,
                                                  site_id: @permalink.site_id, title: @permalink.title } }
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
