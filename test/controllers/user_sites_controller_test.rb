require 'test_helper'

class UserSitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_site = user_sites(:one)
    login_as(users(:koheisg))
  end

  test "should get index" do
    get user_sites_url
    assert_response :success
  end

  test "should get new" do
    get new_user_site_url
    assert_response :success
  end

  test "should create user_site" do
    assert_difference('UserSite.count') do
      post user_sites_url, params: { user_site: { site_id: @user_site.site_id, user_id: @user_site.user_id } }
    end

    assert_redirected_to user_site_url(UserSite.last)
  end

  test "should show user_site" do
    get user_site_url(@user_site)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_site_url(@user_site)
    assert_response :success
  end

  test "should update user_site" do
    patch user_site_url(@user_site), params: { user_site: { site_id: @user_site.site_id, user_id: @user_site.user_id } }
    assert_redirected_to user_site_url(@user_site)
  end

  test "should destroy user_site" do
    assert_difference('UserSite.count', -1) do
      delete user_site_url(@user_site)
    end

    assert_redirected_to user_sites_url
  end
end
