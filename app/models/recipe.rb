class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredient, through: :recipe_ingredients
  has_many :recipe_products
  has_many :products, through: :recipe_products
  accepts_nested_attributes_for :recipe_ingredients
  accepts_nested_attributes_for :recipe_products
  mount_uploader :image, RecipeImageUploader

  validates :name, presence: true, uniqueness: true
  validates :image, presence: true
  validates :description, presence: true
  validates :method, presence: true
  validates :user, presence: true
end
