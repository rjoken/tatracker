class TrackerItem < ApplicationRecord
  belongs_to :tracker_room

  validates :position, inclusion: { in: 0..6 }
  broadcasts_to :tracker_room
end
