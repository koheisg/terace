require 'test_helper'

class HistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as(users(:one))
  end

  test "should get index" do
    get histories_url
    assert_response :success
  end

  test "should get show" do
    get history_url(Audit.last)
    assert_response :success
  end
end
