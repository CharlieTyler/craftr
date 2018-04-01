class AddCounterCacheForUserRecipeViews < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :user_recipe_views_count, :integer
  end
end
