class CategoriesController < ApplicationController
  def index
    @categories = Category.all.page(params[:page])
  end

  def show
    @category = Category.friendly.find(params[:id])
    @products = @category.products.order('weight ASC')
    @recipes  = @category.recipes
    @articles = @category.articles

    # SEO
    @page_description          = @category.seo_description
    @page_keywords             = @category.seo_keywords
    
    # unless @category.instagram_hashtag.blank?
    #   @instas   = InstagramApi.tag(@category.instagram_hashtag).recent_media
    # end
  end
end
