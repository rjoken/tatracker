class TrackerRoom < ApplicationRecord
  has_many :tracker_items, dependent: :destroy

  validates :slug, presence: true, uniqueness: true

  after_create :create_default_items

  private

  def create_default_items
    tracker_items.create(position: 0, image_name: "dragon.png", value: 0)
    tracker_items.create(position: 1, image_name: "thunder.png", value: 0)
    tracker_items.create(position: 2, image_name: "equip.png", value: 0)
    tracker_items.create(position: 3, image_name: "widespread.png", value: 0)
    tracker_items.create(position: 4, image_name: "dcj.png", value: 0)
    tracker_items.create(position: 5, image_name: "megamorph.png", value: 0)
    tracker_items.create(position: 6, image_name: "mbd.png", value: 0)
  end
end
