class AddProductIdToIngredient < ActiveRecord::Migration[5.1]
  def change
    add_column :ingredients, :product_id, :integer
  end
end
