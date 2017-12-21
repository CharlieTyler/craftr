class Category < ApplicationRecord
  has_many :products
  has_many :recipes, through: :products
  mount_uploader :icon, CategoryIconUploader

  validates :name, presence: true, uniqueness: true
  validates :icon, presence: true
end
