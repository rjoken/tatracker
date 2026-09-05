class TrackerRoomsController < ApplicationController
  def show
    @tracker_room = TrackerRoom.find_or_create_by!(slug: params[:room_id])
    @items = @tracker_room.tracker_items.order(:position)

    @mode = params[:mode] == "viewer" ? :viewer : :editor
  end

  def reset
    @tracker_room = TrackerRoom.find_by!(slug: params[:room_id])

    items = @tracker_room.tracker_items.order(:position)

    items.each do |item|
      item.update!(value: 0)
    end

    render turbo_stream: items.map { |item|
      turbo_stream.replace(
        item,
        partial: "tracker_items/tracker_item",
        locals: { tracker_item: item }
      )
    }
  end
end
