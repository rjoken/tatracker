require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  self.fixture_table_names = []

  test "shows four random items from the named player file" do
    get player_path(name: "hippochan")

    assert_response :success
    assert_select "main.player-card--left", count: 1
    assert_select ".player-card__name", "hippochan"
    assert_select ".player-card__flag[alt='nl']", count: 1
    assert_select ".player-card__avatar[alt='hippochan avatar']", count: 1
    assert_select ".player-card__factoid", count: 4
  end

  test "reverses the identity display on the right side" do
    get player_path(name: "hippochan", side: "right")

    assert_response :success
    assert_select "main.player-card--right", count: 1
  end

  test "returns not found when the player file does not exist" do
    get player_path(name: "missing")

    assert_response :not_found
  end
end
