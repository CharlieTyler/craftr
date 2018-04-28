class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  scope :live, -> { where(is_live: true) }

  belongs_to :distillery
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :product_images, dependent: :destroy
  has_many :recipe_products, dependent: :destroy
  has_many :recipes, through: :recipe_products

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
  validates :description_short, presence: true
  validates :description_first, presence: true
  validates :description_second, presence: true
  validates :alcohol_percentage, presence: true
  validates :distillery, presence: true
  validates :category, presence: true
  validates :product_images, presence: true
  validate :distillery_take_less_than_price_if_present


  def self.search(params)
    search_scope = Product

    if params[:keyword].present?
      search_scope = search_scope.where("lower(CONCAT(name,' ', description_short)) LIKE lower(?)", "%#{params[:keyword]}%")
    end

    if params[:category_ids].present?
      search_scope = search_scope.where(category_id: params[:category_ids])
    end

    search_scope
  end

  # Custom validations
  def distillery_take_less_than_price_if_present
    if distillery_take.present?
      distillery_take < (price - 200)
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

  def other_popular_products
    Product.where("(category_id = ?)", category_id).where.not("(id = ?)", id).sort_by{|product| -product.user_product_views.length}
  end

  def is_transactional
    is_live && is_in_stock && weight.present? && distillery_take.present? && distillery.is_transactional
  end
end
