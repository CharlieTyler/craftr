class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  include RankedModel
  ranks :row_order
  
  has_many :products
  has_many :recipes_for_products, through: :products, source: :recipe
  has_many :ingredients
  has_many :recipe_categories
  has_many :recipes, through: :recipe_categories

  has_many :collections

  #articles
  has_many :article_categories
  has_many :articles, through: :article_categories
  mount_uploader :icon, CategoryIconUploader
  mount_uploader :banner_image, CategoryBannerUploader

  validates :name, presence: true, uniqueness: true
  validates :icon, presence: true

  def seo_description
    "Find and buy craft #{name} direct from the distillers. Read recipes, browse articles and buy the likes of #{products.all.sample(3).map(&:name).to_sentence}."
  end

  def seo_keywords
    "#{name}, craft, crafter, craftr, spirits, distillery, bottles, recipes, articles"
  end
end
