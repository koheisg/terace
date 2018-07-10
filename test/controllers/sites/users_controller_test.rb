require 'test_helper'

class Sites::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sites_users_index_url
    assert_response :success
  end

  test "should get show" do
    get sites_users_show_url
    assert_response :success
  end

  test "should get edit" do
    get sites_users_edit_url
    assert_response :success
  end

  test "should get update" do
    get sites_users_update_url
    assert_response :success
  end

  test "should get create" do
    get sites_users_create_url
    assert_response :success
  end

  test "should get destroy" do
    get sites_users_destroy_url
    assert_response :success
  end

end
