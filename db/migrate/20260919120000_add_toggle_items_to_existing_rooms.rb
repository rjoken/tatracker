class AddToggleItemsToExistingRooms < ActiveRecord::Migration[8.1]
  def up
    TrackerRoom.reset_column_information
    TrackerItem.reset_column_information

    TrackerRoom.find_each do |room|
      next if room.tracker_items.where(item_type: 2).exists?

      room.tracker_items.create!(
        item_type: :toggle,
        position: 0,
        value: 0,
        completed: false,
        raigeki: true
      )
    end
  end

  def down
    TrackerItem.where(item_type: 2).delete_all
  end
end
