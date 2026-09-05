class TrackerItemsController < ApplicationController
  before_action :set_tracker_room
  before_action :set_tracker_item

  def increment
    @tracker_item.with_lock do
      @tracker_item.update!(value: @tracker_item.value + 1)
    end

    render turbo_stream: turbo_stream.replace(@tracker_item, partial: "tracker_items/tracker_item", locals: { tracker_item: @tracker_item })
  end

  def decrement
    @tracker_item.with_lock do
      @tracker_item.update!(value: [ @tracker_item.value - 1, 0 ].max)
    end

    render turbo_stream: turbo_stream.replace(@tracker_item, partial: "tracker_items/tracker_item", locals: { tracker_item: @tracker_item })
  end

  private

  def set_tracker_room
    @tracker_room = TrackerRoom.find_by!(slug: params[:room_id])
  end

  def set_tracker_item
    @tracker_item = @tracker_room.tracker_items.find(params[:id])
  end
end
