class AddCounterCacheToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :user_article_views_count, :integer
  end
end
