class Recipe < ApplicationRecord
  belongs_to :author
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_products
  has_many :products, through: :recipe_products
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories
  accepts_nested_attributes_for :recipe_ingredients, reject_if: proc { |attributes| attributes['ingredient_id'].blank? }
  accepts_nested_attributes_for :recipe_products, reject_if: proc { |attributes| attributes['product_id'].blank? }
  accepts_nested_attributes_for :recipe_categories, reject_if: proc { |attributes| attributes['category_id'].blank? }
  has_many :user_favourite_recipes
  has_many :favourited_by, through: :user_favourite_recipes, source: :user
  has_many :recipe_comments

  #articles
  has_many :article_recipes
  has_many :articles, through: :article_recipes

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

  def self.search(params)
    search_scope = Recipe.joins(:recipe_ingredients)

    if params[:keyword].present?
      search_scope = search_scope.where("lower(CONCAT(name,' ', method)) LIKE lower(?)", "%#{params[:keyword]}%")
    end

    search_scope
  end

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
