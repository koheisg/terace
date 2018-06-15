require 'test_helper'

class Articles::HistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get articles_histories_index_url
    assert_response :success
  end

  test "should get show" do
    get articles_histories_show_url
    assert_response :success
  end

end
