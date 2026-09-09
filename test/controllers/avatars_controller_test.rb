require "test_helper"

class AvatarsControllerTest < ActionDispatch::IntegrationTest
  self.fixture_table_names = []

  test "shows a scaled avatar" do
    get avatar_path(name: "hippochan", scale: 128)

    assert_response :success
    assert_select "img[alt='hippochan'][width='128'][height='128']", count: 1
    assert_select "script[type='importmap']", count: 1
  end

  test "uses default scale when missing" do
    get avatar_path(name: "hippochan")

    assert_response :success
    assert_select "img[alt='hippochan'][width='64'][height='64']", count: 1
  end

  test "matches the avatar regardless of case" do
    get avatar_path(name: "HippoChan")

    assert_response :success
    assert_select "img[alt='hippochan']", count: 1
  end

  test "returns not found when avatar does not exist" do
    get avatar_path(name: "missing")

    assert_response :not_found
  end
end
