class AddFeaturedToCategoryProductAndRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :featured, :boolean, :default => false
    add_column :categories, :featured, :boolean, :default => false
    add_column :recipes, :featured, :boolean, :default => false
  end
end
