class StaticPagesController < ApplicationController
  def home
    @carousel_features     = CarouselFeature.rank(:row_order).all
    @all_categories        = Category.all
    @featured_categories   = Category.where(featured: true).first(4)
    @other_products        = Product.where.not(category_id: 1).transactional
    @recipes               = Recipe.last(4)
    @featured_distilleries = Distillery.live.last(3)
    @page_title            = "A curated collection of local gins and other artisan spirits"
    @page_description      = "Explore our collection of fine UK gins, vodkas & rums, and put them to work using our recipe collection. Or just a G&T, your call."
    @page_keywords         = "craft, spirits, artisan, gin, gins, gift, present, english, scottish, british, local, independent, distilleries, #{category_list}, recipes, cocktails"
    # @instas              = InstagramApi.user.recent_media
  end

  def about
    @recipes               = Recipe.last(4)
    @distilleries          = Distillery.last(4)
  end

  def contact
    
  end

  def privacy

  end

  def deliveries

  end

  def returns

  end
end
