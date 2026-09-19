class AddRaigekiBoolToTrackerItems < ActiveRecord::Migration[8.1]
  def up
    add_column :tracker_items, :raigeki, :boolean, default: true
  end

  def down
    remove_column :tracker_items, :raigeki
  end
end
