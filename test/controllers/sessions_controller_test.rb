require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @session = Session.new
    @site = sites(:one)
    @user = users(:one)
  end

  test "should get new" do
    get login_url
    assert_response :success
  end

  test "should create session" do
    post login_url, params: { session: { name: @user.name, password: 'password' } }

    assert_redirected_to root_url
  end

  test "fail create session" do
    post login_url, params: { session: { name: @user.name, password: 'invalid password' } }

    assert_response :success
  end

  test "should destroy session" do
    login_as(@user)

    delete logout_url
    assert_redirected_to login_url
  end
end
