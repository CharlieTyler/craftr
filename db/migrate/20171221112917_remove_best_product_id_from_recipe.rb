class RemoveBestProductIdFromRecipe < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipes, :best_product_id
  end
end
