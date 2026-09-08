require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  self.fixture_table_names = []

  test "shows four random items from the named player file" do
    get player_path(name: "hippochan")

    assert_response :success
    assert_select "h1", text: /hippochan/
    assert_select "h1 img[alt='nl']", count: 1
    assert_select "header > img[alt='hippochan avatar']", count: 1
    assert_select "section", count: 4
    assert_select "section h2", count: 4
    assert_select "section p", count: 4
  end

  test "returns not found when the player file does not exist" do
    get player_path(name: "missing")

    assert_response :not_found
  end
end
