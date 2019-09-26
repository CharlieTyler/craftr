class Recipe < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  acts_as_taggable_on :rtags
  
  belongs_to :author
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_products, dependent: :destroy
  has_many :products, through: :recipe_products
  has_many :recipe_categories, dependent: :destroy
  has_many :categories, through: :recipe_categories
  accepts_nested_attributes_for :recipe_ingredients, reject_if: proc { |attributes| attributes['ingredient_id'].blank? }
  accepts_nested_attributes_for :recipe_products, reject_if: proc { |attributes| attributes['product_id'].blank? }
  accepts_nested_attributes_for :recipe_categories, reject_if: proc { |attributes| attributes['category_id'].blank? }
  has_many :user_favourite_recipes, dependent: :destroy
  has_many :favourited_by, through: :user_favourite_recipes, source: :user
  has_many :recipe_comments, dependent: :destroy

  has_many :user_recipe_views

  #articles
  has_many :article_recipes, dependent: :destroy
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

  def seo_description
    "#{description} - a cocktail recipe by #{author.name}, using #{ingredient_list}"
  end

  def seo_keywords
    "craft, spirits, cocktail, recipe, recipes, #{categories.map(&:name).join(", ")}, #{ingredient_list}, craftr, crafter"
  end

  def self.search(params)
    search_scope = Recipe

    if params[:keyword].present?
      search_scope = search_scope.where("lower(CONCAT(name,' ', method)) LIKE lower(?)", "%#{params[:keyword]}%")
    end

    search_scope
  end

  def ingredient_list
    name_array = []
    ingredients.first(5).each { |i| name_array << i.name }
    name_array.to_sentence
  end

  def whisk_ingredients_list
    ingredients_list = []
    # If it's got a category, which isn't other, don't add it to the list, because we're going to add a sample one to the basket
    ingredients.each { |i| i.category.present? && i.category_id != 3 ? nil : ingredients_list << i.name }
    "'"+ingredients_list.join("', '")+"'"
  end

  def product_to_add
    # Ingredients direcly linked to a product
    product_ingredients = ingredients.where.not(product_id: nil)
    # Ingredients with a proper category (i.e. not 'other')
    category_ingredients = ingredients.where.not(category_id: [nil, 3])
    # If there's a specifically named product, use that, else pick a product from a specifically named category, else nil
    if product_ingredients.present?
      product_ingredients.first.product
    elsif category_ingredients.present?
      category = category_ingredients.first.category
      if category.products.transactional.size > 0
        category.products.transactional.sample(1).first
      else
        nil
      end
    else
      nil
    end
  end

  def tags
    tags_array = []
    ingredients.where(category: "spirit").each { |i| tags_array << i.name }
    tags_array << category
    tags array
  end

  #https://stackoverflow.com/questions/2611338/using-ruby-to-find-similar-recipes-based-on-ingredients-they-contain
  
end
