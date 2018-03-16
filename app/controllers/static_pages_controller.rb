class StaticPagesController < ApplicationController
  def home
    @featured_categories = Category.where(featured: true).first(3)
    @recipes             = Recipe.last(3)
    @featured_products   = Product.all
    @featured_product    = Product.find(2)
    # @instas              = InstagramApi.user.recent_media
  end

  def about

  end

  def contact
    
  end
end
