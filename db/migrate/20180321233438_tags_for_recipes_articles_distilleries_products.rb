class TagsForRecipesArticlesDistilleriesProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :tags, :string
    add_column :articles, :tags, :string
    add_column :distilleries, :tags, :string
    rename_column :recipes, :tag, :tags
  end
end
