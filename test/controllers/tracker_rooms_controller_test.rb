require "test_helper"

class TrackerRoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get tracker_rooms_show_url
    assert_response :success
  end
end
