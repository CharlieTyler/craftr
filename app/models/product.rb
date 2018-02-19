class Product < ApplicationRecord
  belongs_to :distillery
  belongs_to :category
  has_many :reviews
  has_many :product_images
  has_many :recipe_products
  has_many :recipes, through: :recipe_products

  accepts_nested_attributes_for :product_images

  validates :name, presence: true
  validates :SKU, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { less_than_or_equal_to: 100 }
  validates :description_short, presence: true
  validates :description_first, presence: true
  validates :description_second, presence: true
  validates :alcohol_percentage, presence: true
  validates :distillery, presence: true
  validates :category, presence: true
  validates :product_images, presence: true

  def average_review
    if reviews.blank?
      return "No reviews yet, be the first to add one!"
    else
      average = reviews.average('rating')
      score   = average.round(1)
      count   = reviews.count
      "#{score}/5.0 (#{count})"
    end
  end
end