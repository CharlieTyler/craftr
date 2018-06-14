class ArticlesController < ApplicationController
  def show
    @article = Article.friendly.find(params[:id])
    UserArticleView.create(user: user_signed_in? ? current_user : nil, article: @article)
    # negated sign to reverse array as it automatically sorts in ascending order
    @most_read_articles = Article.all.sort_by{|article| -article.user_article_views.size}.first(5)
  end

  def index
    @articles = Article.order('created_at DESC')
    @featured_articles = Article.where(featured: true)
    @tags = Article.tag_counts_on(:tags)
  end

  def tag
    @tag = ActsAsTaggableOn::Tag.friendly.find(params[:tag])
    @tags = Article.tag_counts_on(:tags)
    @articles = Article.tagged_with(@tag)
  end
end
