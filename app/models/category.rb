class Category < ApplicationRecord
  has_many :products
  has_many :recipes, through: :products

  validates :name, presence: true, uniqueness: true
end
