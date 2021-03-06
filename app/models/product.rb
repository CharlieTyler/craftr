class Product < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  self.per_page = 20
  extend FriendlyId
  friendly_id :name, use: :slugged

  scope :live, -> { where(is_live: true, is_test: false) }
  scope :transactional, -> { where(is_live: true, is_in_stock: true, is_test: false).where.not(weight: nil, distillery_take: nil) }
  scope :non_transactional, -> { where(is_live: true, is_test: false, weight: nil, distillery_take: nil) }
  scope :similar_products, ->(product) { where("id != ? and category_id = ?", product.id, product.category.id) }
  scope :strength, -> (min, max) { where('alcohol_percentage > ? AND alcohol_percentage < ?', min, max) }
  scope :category, -> (category_id) { where category_id: category_id }

  belongs_to :distillery
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :product_images, dependent: :destroy
  has_many :recipe_products, dependent: :destroy
  has_many :recipes, through: :recipe_products
  has_many :collection_products, dependent: :destroy
  has_many :collections, through: :collection_products

  has_many :sold_items

  #articles
  has_many :article_products, dependent: :destroy
  has_many :articles, through: :article_products

  has_many :user_favourite_products, dependent: :destroy
  has_many :favourited_by, through: :user_favourite_products, source: :user

  has_many :user_product_views, dependent: :destroy

  accepts_nested_attributes_for :product_images

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 100 }
  validates :weight, presence: true, numericality: true
  validates :description_short, presence: true
  validates :description_first, presence: true
  validates :description_second, presence: true
  validates :alcohol_percentage, presence: true
  validates :distillery, presence: true
  validates :category, presence: true
  validates :product_images, presence: true
  validate :distillery_take_less_than_price_if_present
  validate :original_price_is_more_than_price_if_present

  def self.search(params)
    search_scope = Product

    if params[:keyword].present?
      search_scope = search_scope.where("lower(CONCAT(name,' ', description_short)) LIKE lower(?)", "%#{params[:keyword]}%")
    end

    search_scope
  end

  def self.filter(params)
    filter_scope = Product

    if params[:category_id].present?
      params[:category_id].reject!{ |id| id.blank? }
      filter_scope = filter_scope.where(category_id: params[:category_id])
    end

    if params[:distillery_id].present?
      params[:distillery_id].reject!{ |id| id.blank? }
      filter_scope = filter_scope.where(distillery_id: params[:distillery_id])
    end

    if params[:strength_min].present?
      filter_scope = filter_scope.where('alcohol_percentage > ?', params[:strength_min])
    end

    if params[:strength_max].present?
      filter_scope = filter_scope.where('alcohol_percentage > ?', params[:strength_min])
    end

    filter_scope
  end

  def seo_description
    "#{name}, made by #{distillery.name} in #{distillery.location}. #{description_short}."
  end

  def seo_keywords
    word_array = []
    word_array << category.name
    word_array << "craft, spirits, craftr, crafter"
    word_array << distillery.name
    word_array << distillery.location
    word_array.join(", ")
  end

  def human_readable_price
    precision = price % 100 == 0 ? 0 : 2
    number_to_currency(price.to_f / 100, unit: "£", precision: precision)
  end

  def human_readable_original_price
    precision = original_price % 100 == 0 ? 0 : 2
    number_to_currency(original_price.to_f / 100, unit: "£", precision: precision)
  end

  # Custom validations
  def distillery_take_less_than_price_if_present
    if distillery_take.present?
      unless distillery_take < (price - 200)
        errors.add(:distillery_take, "Distillery take must be at least £2 lower than price")
      end
    else
      return true
    end
  end

  def original_price_is_more_than_price_if_present
    if original_price.present?
      unless original_price > price
        errors.add(:original_price, "Original price must be higher than sale price")
      end
    else
      return true
    end
  end

  # Sales
  def total_sold
    sold_items.sum(&:quantity)
  end
  # Rating calculations
  def average_rating
    reviews.average('rating').to_f
  end

  def half_stars
    n = (average_rating * 2).round(0)
    n % 2
  end

  def whole_stars
    n = (average_rating * 2).round(0)
    (n - half_stars) / 2
  end

  def blank_half_stars
    if half_stars == 1
      return 1
    else
      return 0
    end
  end

  def blank_whole_stars
    bs = 5 - whole_stars
    if half_stars == 1
      bs - 1
    else
      bs
    end
  end

  # Profitability calcs
  def gross_profit(shipping_price)
    price + shipping_price - distillery_take
  end

  def payment_cost(shipping_price)
    (price + shipping_price) * 0.014 + 20
  end

  def net_profit(shipping_price, shipping_cost)
    price + shipping_price - distillery_take - shipping_cost - payment_cost(shipping_price)
  end

  def other_popular_products
    Product.transactional.where("(category_id = ?)", category_id).where.not("(id = ?)", id).sort_by{|product| -product.user_product_views.length}
  end

  def is_transactional
    is_live && is_in_stock && weight.present? && distillery_take.present? && distillery.is_transactional
  end

  def related_recipes
    recipes + category.recipes.first(3)    
  end

  def related_products

  end
end
