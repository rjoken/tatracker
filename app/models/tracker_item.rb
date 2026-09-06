class TrackerItem < ApplicationRecord
  belongs_to :tracker_room

  enum :item_type, { counter: 0, progression: 1 }, prefix: true

  validates :position, presence: true
  validate :position_within_type_range

  broadcasts_to :tracker_room

  private

  def position_within_type_range
    return if item_type_counter? && (0..6).cover?(position)
    return if item_type_progression? && (0..5).cover?(position)

    errors.add(:position, "is out of range for #{item_type}")
  end
end
