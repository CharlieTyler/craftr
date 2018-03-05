class AddSlugToRecipesArticlesDistilleriesCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :slug, :string
    add_index :recipes, :slug, unique: true
    add_column :articles, :slug, :string
    add_index :articles, :slug, unique: true
    add_column :distilleries, :slug, :string
    add_index :distilleries, :slug, unique: true
    add_column :categories, :slug, :string
    add_index :categories, :slug, unique: true
  end
end
