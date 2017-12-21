class CreateRecipeProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_products do |t|
      t.integer :recipe_id
      t.integer :product_id
      t.timestamps
    end
  end
end
