class AuthorsController < ApplicationController
  def show
    @author = Author.friendly.find(params[:id])
    @recipes = @author.recipes.all
    @articles = @author.articles.all
  end

  def index
    @authors = Author.all
  end
end
