class AddSchemaAttributesToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :prep_time_in_minutes, :integer
    add_column :recipes, :cuisine, :integer
    Recipe.update_all(cuisine: 'cocktail', prep_time_in_minutes: 5)
  end
end
