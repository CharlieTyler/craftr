class ArticlesController < ApplicationController
  def show
    @article = Article.friendly.find(params[:id])
  end

  def index
    if params[:tag]
      @tag = ActsAsTaggableOn::Tag.friendly.find(params[:tag])
      @articles = Article.tagged_with(@tag)
    else
      @articles = Article.all
    end
  end
end
