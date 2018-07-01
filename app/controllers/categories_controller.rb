class CategoriesController < ApplicationController
  def index
    @categories = Category.all.page(params[:page])
  end

  def show
    @category = Category.friendly.find(params[:id])
    @featured_products = @category.products.live.where(featured: true)
    @featured_recipes = @category.recipes.where(featured: true)
    @featured_articles = @category.articles.where(featured: true)
    @products = @category.products.live
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
