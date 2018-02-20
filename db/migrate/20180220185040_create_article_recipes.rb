class CreateArticleRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :article_recipes do |t|
      t.integer :article_id
      t.integer :recipe_id
      t.timestamps
    end
  end
end
