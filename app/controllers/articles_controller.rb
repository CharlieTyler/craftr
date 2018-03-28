class ArticlesController < ApplicationController
  def show
    @article = Article.friendly.find(params[:id])
  end

  def index
    @articles = Article.all
    @tags = ActsAsTaggableOn::Tag.all
  end

  def tag
    @tag = ActsAsTaggableOn::Tag.friendly.find(params[:tag])
    @tags = ActsAsTaggableOn::Tag.all
    @articles = Article.tagged_with(@tag)
  end
end
