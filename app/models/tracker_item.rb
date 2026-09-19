class TrackerItem < ApplicationRecord
  belongs_to :tracker_room

  enum :item_type, { counter: 0, progression: 1, toggle: 2 }, prefix: true

  RAIGEKI_IMAGE = "raigeki.png".freeze
  DARK_HOLE_IMAGE = "darkhole.png".freeze

  validates :position, presence: true
  validate :position_within_type_range

  broadcasts_to :tracker_room

  # Toggle items swap between two sprites instead of carrying a fixed image.
  def sprite_image_name
    return image_name unless item_type_toggle?

    raigeki? ? RAIGEKI_IMAGE : DARK_HOLE_IMAGE
  end

  private

  def position_within_type_range
    return if item_type_counter? && (0..6).cover?(position)
    return if item_type_progression? && (0..5).cover?(position)
    return if item_type_toggle? && position == 0

    errors.add(:position, "is out of range for #{item_type}")
  end
end
