class CreateTrackerItems < ActiveRecord::Migration[8.1]
  def change
    create_table :tracker_items do |t|
      t.references :tracker_room, null: false, foreign_key: true
      t.integer :position, null: false
      t.string :image_name, null: false
      t.integer :value, null: false, default: 0

      t.timestamps
    end

    add_index :tracker_items, [ :tracker_room_id, :position ], unique: true
  end
end
