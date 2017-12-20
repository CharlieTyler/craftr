class Product < ApplicationRecord
  belongs_to :distillery
  belongs_to :category
  has_many :reviews
  has_many :product_images

  accepts_nested_attributes_for :product_images

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
