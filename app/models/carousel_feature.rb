class CarouselFeature < ApplicationRecord
  validates :line_1, presence: true
  validates :line_2, presence: true
  validates :cta_text, presence: true
  validates :link_url, presence: true
  validates :image, presence: true

  mount_uploader :image, DistilleryBannerImageUploader
end
