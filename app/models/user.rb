class User < ApplicationRecord
  #favourite recipes
  has_many :user_favourite_recipes
  has_many :favourite_recipes, through: :user_favourite_recipes, source: :recipe

  #product reviews
  has_many :reviews

  #actual recipes
  has_many :recipes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def favourited?(recipe)
    favourite_recipes.include? recipe
  end
end
