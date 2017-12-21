class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :message, presence: true
  validates :rating, presence: true, numericality: true
  
end
