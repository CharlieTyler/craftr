class CreateUserRecipeViews < ActiveRecord::Migration[5.1]
  def change
    create_table :user_recipe_views do |t|
      t.integer :user_id
      t.integer :recipe_id
      t.timestamps
    end
  end
end
