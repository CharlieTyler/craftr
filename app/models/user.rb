class User < ApplicationRecord
  #favourite recipes
  has_many :user_favourite_recipes
  has_many :favourite_recipes, through: :user_favourite_recipes, source: :recipe

  #recipe comments
  has_many :recipe_comments

  #product reviews
  has_many :reviews

  #recently viewed
  has_many :user_product_views
  has_many :viewed_products, through: :user_product_views, source: :product

  #actual recipes
  has_many :recipes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def favourited?(recipe)
    favourite_recipes.include? recipe
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