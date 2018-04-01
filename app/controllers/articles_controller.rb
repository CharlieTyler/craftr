class ArticlesController < ApplicationController
  def show
    @article = Article.friendly.find(params[:id])
    if user_signed_in?
      current_user.read_articles << @article
    end
    @most_read_articles = Article.all.sort_by{|article| article.user_article_views.length}.first(5)
  end

  def index
    @articles = Article.all
    @tags = ActsAsTaggableOn::Tag.all
  end

  def tag
    @tag = ActsAsTaggableOn::Tag.friendly.find(params[:tag])
    @tags = Article.tag_counts_on(:tags)
    @articles = Article.tagged_with(@tag)
  end
end
