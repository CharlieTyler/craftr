class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_products
  has_many :products, through: :recipe_products
  accepts_nested_attributes_for :recipe_ingredients
  accepts_nested_attributes_for :recipe_products
  has_many :user_favourite_recipes
  has_many :favourited_by, through: :user_favourite_recipes, source: :user
  has_many :recipe_comments
  mount_uploader :image, RecipeImageUploader
  mount_uploader :banner_image, RecipeBannerImageUploader

  validates :name, presence: true, uniqueness: true
  validates :image, presence: true
  validates :description, presence: true
  validates :method, presence: true

  CATEGORIES = {
    'Long': 'Long',
    'Short': 'Short',
    'Other': 'Other'
  }

  def ingredient_list
    count      = ingredients.count
    name_array = []
    ingredients.first(5).each { |i| name_array << i.name }
    name_array.to_sentence
  end

  def tags
    tags_array = []
    ingredients.where(category: "spirit").each { |i| tags_array << i.name }
    tags_array << category
    tags array
  end

  #https://stackoverflow.com/questions/2611338/using-ruby-to-find-similar-recipes-based-on-ingredients-they-contain
  
end
