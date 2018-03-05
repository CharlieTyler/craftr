class ArticlesController < ApplicationController
  def show
    @article = Article.friendly.find(params[:id])
  end

  def index
    @articles = Article.all
  end
end
