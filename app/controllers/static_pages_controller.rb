class StaticPagesController < ApplicationController
  def home
    @featured_categories = Category.where(featured: true).first(3)
    @recipes             = Recipe.last(3)    
  end

  def about

  end
end
