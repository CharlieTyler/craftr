class User < ApplicationRecord
  #cart
  has_many :orders

  #addresses
  has_many :addresses

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

  #recently viewed
  has_many :user_product_views, dependent: :destroy
  has_many :viewed_products, through: :user_product_views, source: :product

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def is_author?
    type == "Author"
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
