class AddProgressionToTrackerItems < ActiveRecord::Migration[8.1]
  PROGRESSION_STAGES = [
    [ "Mountain", "mountain.png" ],
    [ "Ocean", "sea.png" ],
    [ "Desert", "desert.png" ],
    [ "Meadow", "meadow.png" ],
    [ "Forest", "forest.png" ],
    [ "Final 6", "labmage.png" ]
  ].freeze

  class MigrationTrackerRoom < ApplicationRecord
    self.table_name = "tracker_rooms"
  end

  class MigrationTrackerItem < ApplicationRecord
    self.table_name = "tracker_items"
  end

  def up
    add_column :tracker_items, :item_type, :integer, default: 0, null: false
    add_column :tracker_items, :completed, :boolean, default: false, null: false
    add_column :tracker_items, :stage_name, :string

    MigrationTrackerRoom.find_each do |tracker_room|
      PROGRESSION_STAGES.each_with_index do |(stage_name, image_name), position|
        MigrationTrackerItem.find_or_create_by!(
          tracker_room_id: tracker_room.id,
          item_type: 1,
          position: position
        ) do |item|
          item.image_name = image_name
          item.value = 0
          item.completed = false
          item.stage_name = stage_name
        end
      end
    end

    add_index :tracker_items,
      [ :tracker_room_id, :item_type, :position ],
      unique: true,
      name: "index_tracker_items_on_room_type_position"
  end

  def down
    remove_index :tracker_items, name: "index_tracker_items_on_room_type_position"
    remove_column :tracker_items, :stage_name
    remove_column :tracker_items, :completed
    remove_column :tracker_items, :item_type
  end
end
