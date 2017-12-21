class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true, uniqueness: true
  validates :category, presence: true

  CATEGORIES = {
    'Spirit': 'Spirit',
    'Mixer': 'Mixer',
    'Fruit': 'Fruit',
    'Herb': 'Herb',
    'Bitter': 'Bitter',
    'Flavouring': 'Flavouring',
    'Other': 'Other'
  }
end
