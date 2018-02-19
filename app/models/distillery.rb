class Distillery < ApplicationRecord
  has_many :products

  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
  validates :description_short, presence: true
  validates :description_first, presence: true
  validates :description_second, presence: true

  mount_uploader :banner_image, DistilleryBannerImageUploader
  
end
