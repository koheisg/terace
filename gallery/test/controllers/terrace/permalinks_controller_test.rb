require 'test_helper'

module Terrace
  class ArticlesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should show article" do
      get 'http://one.example.com/MyString'
      assert_response :success
    end

    test "should show page" do
      get 'http://one.example.com/MyString'
      assert_response :success
    end

    test "should show archive" do
      get 'http://one.example.com/MyString'
      assert_response :success
    end

    #test "should show rss feed" do
    #  get 'http://one.example.com/feed'
    #  assert_response :success
    #end
  end
end
