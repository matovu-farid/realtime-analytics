
require "test_helper"

class SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get searches_index_url
    assert_response :success
  end

  test "should get analytics" do
    get searches_analytics_url
    assert_response :success
  end

  test "should save search" do
    post searches_save_url, params: { search: { text: "test search" } }
    assert_response :success
  end
end