class Category < ApplicationRecord
  has_many :products
  has_many :recipes, through: :products
  has_many :ingredients
  mount_uploader :icon, CategoryIconUploader
  mount_uploader :banner_image, CategoryBannerUploader

  validates :name, presence: true, uniqueness: true
  validates :icon, presence: true
end