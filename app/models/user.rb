class User < ApplicationRecord

  #author
  has_one :author

  #favourite products
  has_many :user_favourite_products, dependent: :destroy
  has_many :favourite_products, through: :user_favourite_products, source: :product

  #favourite recipes
  has_many :user_favourite_recipes, dependent: :destroy
  has_many :favourite_recipes, through: :user_favourite_recipes, source: :recipe

  #recipe comments
  has_many :recipe_comments, dependent: :destroy

  #product reviews
  has_many :reviews, dependent: :destroy

  #recently viewed products
  has_many :user_product_views, dependent: :destroy
  has_many :viewed_products, through: :user_product_views, source: :product

  #viewed recipes
  has_many :user_recipe_views, dependent: :destroy
  has_many :viewed_recipes, through: :user_recipe_views, source: :recipe

  #read articles
  has_many :user_article_views, dependent: :destroy
  has_many :read_articles, through: :user_article_views, source: :article

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validates that age verification is a) present and b) true
  validates :age_verified, exclusion: { in: [nil], message: "Age verification is a requirement" }
  validates :age_verified, inclusion: { in: [true], message: "Age verification is a requirement" }

  def is_author?
    author.present?
  end

  def favourited_recipe?(recipe)
    favourite_recipes.include? recipe
  end

  def favourited_product?(product)
    favourite_products.include? product
  end

  def recently_viewed_products
    viewed_user_products = user_product_views.where("(created_at > ?)", Time.now - 5.days)
    recently_viewed_products = []
    viewed_user_products.each do |vup|
      recently_viewed_products.push(vup.product) unless recently_viewed_products.include?(vup.product)
    end
    recently_viewed_products
  end
end
