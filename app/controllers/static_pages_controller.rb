class StaticPagesController < ApplicationController
  def home
    @carousel_features     = CarouselFeature.all
    @featured_categories   = Category.where(featured: true).first(4)
    @recipes               = Recipe.last(3)
    @featured_products     = Product.where(featured: true).first(4)
    @featured_distilleries = Distillery.last(4)
    @instas              = InstagramApi.user.recent_media
  end

  def about

  end

  def contact
    
  end
end
