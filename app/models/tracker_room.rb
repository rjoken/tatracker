class TrackerRoom < ApplicationRecord
  has_many :tracker_items, dependent: :destroy

  validates :slug, presence: true, uniqueness: true

  after_create :create_default_items

  COUNTER_IMAGES = [
    "dragon.png",
    "thunder.png",
    "equip.png",
    "widespread.png",
    "dcj.png",
    "megamorph.png",
    "mbd.png"
  ].freeze

  PROGRESSION_STAGES = [
    [ "Mountain", "mountain.png" ],
    [ "Ocean", "sea.png" ],
    [ "Desert", "desert.png" ],
    [ "Meadow", "meadow.png" ],
    [ "Forest", "forest.png" ],
    [ "Final 6", "labmage.png" ]
  ].freeze

  private

  def create_default_items
    COUNTER_IMAGES.each_with_index do |image_name, position|
      tracker_items.create!(
        item_type: :counter,
        position: position,
        image_name: image_name,
        value: 0,
        completed: false
      )
    end

    PROGRESSION_STAGES.each_with_index do |(stage_name, image_name), position|
      tracker_items.create!(
        item_type: :progression,
        position: position,
        image_name: image_name,
        value: 0,
        completed: false,
        stage_name: stage_name
      )
    end
  end
end
