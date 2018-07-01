class AuthorsController < ApplicationController
  def show
    @author = Author.friendly.find(params[:id])
    @recipes = @author.recipes.all
    @articles = @author.articles.all
  end

  def index
    @authors = Author.all.page(params[:page])
    @featured_articles = Article.where(featured: true)
  end
end
