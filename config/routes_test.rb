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

# FILEPATH: /Users/faridmatovu/projects/realtime-analytics/test/controllers/routes_test.rb

require "test_helper"

class RoutesTest < ActionDispatch::IntegrationTest
  test "should route to searches index" do
    assert_routing "/searches/index", { controller: "searches", action: "index" }
  end

  test "should route to searches analytics" do
    assert_routing "/searches/analytics", { controller: "searches", action: "analytics" }
  end

  test "should route to searches save" do
    assert_routing({ method: "post", path: "/searches/save" }, { controller: "searches", action: "save" })
  end

  test "should route root to searches index" do
    assert_routing "/", { controller: "searches", action: "index" }
  end
end