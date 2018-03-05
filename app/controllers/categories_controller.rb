class CategoriesController < ApplicationController
  def index

  end

  def show
    @category = Category.friendly.find(params[:id])
    @products = @category.products
    @recipes  = @category.recipes
    @articles = @category.articles
    unless @category.instagram_hashtag.blank?
      @instas   = InstagramApi.tag(@category.instagram_hashtag).recent_media
    end
  end
end
