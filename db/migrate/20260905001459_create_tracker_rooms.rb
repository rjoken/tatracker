class CreateTrackerRooms < ActiveRecord::Migration[8.1]
  def change
    create_table :tracker_rooms do |t|
      t.string :slug

      t.timestamps
    end
    add_index :tracker_rooms, :slug, unique: true
  end
end
