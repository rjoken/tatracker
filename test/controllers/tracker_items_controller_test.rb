require "test_helper"

class TrackerItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @room = TrackerRoom.create!(slug: "toggle-test")
    @toggle = @room.tracker_items.item_type_toggle.first
  end

  test "room shows the raigeki sprite next to the counters" do
    get tracker_room_path(@room.slug)

    assert_response :success
    assert_select ".tracker-grid .tracker-item img[src*=?]", "raigeki"
  end

  test "toggling swaps raigeki for dark hole" do
    patch toggle_raigeki_tracker_item_path(@room.slug, @toggle)

    assert_response :success
    assert_not @toggle.reload.raigeki
    assert_equal "darkhole.png", @toggle.sprite_image_name

    patch toggle_raigeki_tracker_item_path(@room.slug, @toggle)

    assert @toggle.reload.raigeki
  end

  test "toggle_raigeki rejects non-toggle items" do
    counter = @room.tracker_items.item_type_counter.first

    patch toggle_raigeki_tracker_item_path(@room.slug, counter)

    assert_response :unprocessable_entity
  end

  test "reset restores raigeki" do
    @toggle.update!(raigeki: false)

    patch reset_tracker_room_path(@room.slug)

    assert_response :success
    assert @toggle.reload.raigeki
  end
end
