class TrackerRoomsController < ApplicationController
  def show
    @tracker_room = TrackerRoom.find_or_create_by!(slug: params[:room_id])
    @items = @tracker_room.tracker_items.order(:position)

    @mode = params[:mode] == "viewer" ? :viewer : :editor
  end

  def reset
    @tracker_room = TrackerRoom.find_by!(slug: params[:room_id])
    @tracker_room.tracker_items.update_all(value: 0)
    head :no_content
  end
end
