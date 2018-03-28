class ArticlesController < ApplicationController
  def show
    @article = Article.friendly.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def tag
    @tag = ActsAsTaggableOn::Tag.friendly.find(params[:tag])
    @articles = Article.tagged_with(@tag)
  end
end
