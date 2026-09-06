class TrackerRoomsController < ApplicationController
  def show
    @tracker_room = TrackerRoom.find_or_create_by!(slug: params[:room_id])
    @counter_items = @tracker_room.tracker_items.item_type_counter.order(:position)
    @progression_items = @tracker_room.tracker_items.item_type_progression.order(:position)

    @mode = case params[:mode]
    when "viewer"
      :viewer
    when "progression"
      :progression
    else
      :editor
    end
  end

  def reset
    @tracker_room = TrackerRoom.find_by!(slug: params[:room_id])

    items = @tracker_room.tracker_items.order(:position)

    items.each do |item|
      if item.item_type_progression?
        item.update!(completed: false)
      else
        item.update!(value: 0)
      end
    end

    render turbo_stream: items.map { |item|
      turbo_stream.replace(
        item,
        partial: "tracker_items/tracker_item",
        locals: { tracker_item: item, mode: :editor }
      )
    }
  end
end
