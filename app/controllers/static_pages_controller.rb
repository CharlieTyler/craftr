class StaticPagesController < ApplicationController
  def home
    @featured_categories = Category.where(featured: true).first(3)
    @recipes             = Recipe.last(3)
    @featured_products   = Product.where(featured: true).first(3)
    @instas              = InstagramApi.user.recent_media  
  end

  def about

  end
end
