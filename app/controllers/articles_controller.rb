class ArticlesController < ApplicationController
  def show
    @article = Article.friendly.find(params[:id])
    UserArticleView.create(user: user_signed_in? ? current_user : nil, article: @article)
    # negated sign to reverse array as it automatically sorts in ascending order
    @most_read_articles = Article.all.sort_by{|article| -article.user_article_views.size}.first(5)
    @page_description          = @article.seo_description
    @page_keywords             = @article.seo_keywords
  end

  def index
    @articles = Article.page(params[:page]).order('created_at DESC')
    @all_articles = Article.all
    @featured_articles = Article.where(featured: true)
    @tags = Article.tag_counts_on(:tags)
    @page_description          = "Read expert articles from CRAFTR's bloggers on everything craft spirit! #{@all_articles.length} articles ready to read."
    @page_keywords             = "craft, spirits, bloggers, articles, instagram, #{category_list}"
  end

  def tag
    @tag = ActsAsTaggableOn::Tag.friendly.find(params[:tag])
    @tags = Article.tag_counts_on(:tags)
    @articles = Article.tagged_with(@tag)
  end
end
