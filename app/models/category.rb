class Category < ApplicationRecord
  has_many :products
  has_many :recipes_for_products, through: :products, source: :recipe
  has_many :ingredients
  has_many :recipe_categories
  has_many :recipes, through: :recipe_categories

  #articles
  has_many :article_categories
  has_many :articles, through: :article_categories
  mount_uploader :icon, CategoryIconUploader
  mount_uploader :banner_image, CategoryBannerUploader

  validates :name, presence: true, uniqueness: true
  validates :icon, presence: true
end
