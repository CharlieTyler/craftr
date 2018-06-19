class StaticPagesController < ApplicationController
  def home
    @carousel_features     = CarouselFeature.rank(:row_order).all
    @all_categories        = Category.all
    @featured_categories   = Category.where(featured: true).first(4)
    @recipes               = Recipe.last(3)
    @featured_distilleries = Distillery.live.last(4)
    @page_description      = "The UK's only marketplace and community dedicated to local, independent craft spirits. Discover new gins, vodkas and other spirits, and buy directly from the distillers."
    # @instas              = InstagramApi.user.recent_media
  end

  def about

  end

  def contact
    
  end

  def privacy

  end
end
