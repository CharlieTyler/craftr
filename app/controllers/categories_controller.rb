class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.friendly.find(params[:id])
    @featured_products = @category.products.where(featured: true)
    @featured_recipes = @category.recipes.where(featured: true)
    @featured_articles = @category.articles.where(featured: true)
    @products = @category.products
    @recipes  = @category.recipes
    @articles = @category.articles
    # unless @category.instagram_hashtag.blank?
    #   @instas   = InstagramApi.tag(@category.instagram_hashtag).recent_media
    # end
  end
end
