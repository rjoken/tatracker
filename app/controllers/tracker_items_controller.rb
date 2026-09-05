class TrackerItemsController < ApplicationController
  before_action :set_tracker_room
  before_action :set_tracker_item

  def increment
    @tracker_item.with_lock do
      @tracker_item.update!(value: @tracker_item.value + 1)
    end

    head :no_content
  end

  def decrement
    @tracker_item.with_lock do
      @tracker_item.update!(value: [ @tracker_item.value - 1, 0 ].max)
    end

    head :no_content
  end

  private

  def set_tracker_room
    @tracker_room = TrackerRoom.find_by!(slug: params[:room_id])
  end

  def set_tracker_item
    @tracker_item = @tracker_room.tracker_items.find(params[:id])
  end
end
