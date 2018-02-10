class ChangeIngredientCategoryToForeignkey < ActiveRecord::Migration[5.1]
  def change
    rename_column :ingredients, :category, :classification
    add_column :ingredients, :category_id, :integer
  end
end
