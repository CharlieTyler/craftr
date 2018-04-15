class CreateUserArticleViews < ActiveRecord::Migration[5.1]
  def change
    create_table :user_article_views do |t|
      t.integer :user_id
      t.integer :article_id
      t.timestamps
    end
  end
end
