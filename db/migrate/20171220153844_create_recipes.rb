class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :image
      t.text :description
      t.text :method
      t.integer :best_product_id
      t.integer :user_id
      t.timestamps
    end
  end
end
