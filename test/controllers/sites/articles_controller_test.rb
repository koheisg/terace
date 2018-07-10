require 'test_helper'

class Sites::ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sites_articles_index_url
    assert_response :success
  end

end
