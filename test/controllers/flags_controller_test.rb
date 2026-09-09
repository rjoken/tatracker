require "test_helper"

class FlagsControllerTest < ActionDispatch::IntegrationTest
  self.fixture_table_names = []

  test "shows a player's flag at original size" do
    get flag_path(name: "hippochan")

    assert_response :success
    assert_select "img[alt='nl']", count: 1
    assert_select "img[width]", count: 0
    assert_select "img[height]", count: 0
  end

  test "returns not found when player file does not exist" do
    get flag_path(name: "missing")

    assert_response :not_found
  end
end
