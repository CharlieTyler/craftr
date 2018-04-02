class AddImageToIngredient < ActiveRecord::Migration[5.1]
  def change
    add_column :ingredients, :image, :string
    add_column :recipe_ingredients, :row_order, :integer
    add_index :recipe_ingredients, :row_order
  end
end
