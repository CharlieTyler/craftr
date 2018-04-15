class RemoveTagsFromSchema < ActiveRecord::Migration[5.1]
  def change
    remove_column :articles, :tags
    remove_column :distilleries, :tags
    remove_column :products, :tags
    remove_column :recipes, :tags
  end
end
