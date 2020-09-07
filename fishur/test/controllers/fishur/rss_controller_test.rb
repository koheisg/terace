require 'test_helper'

module Fishur
  class RssControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

  test "should show rss feed" do
    get 'http://one.example.com/feed'
    assert_response :success
  end
  end
end
