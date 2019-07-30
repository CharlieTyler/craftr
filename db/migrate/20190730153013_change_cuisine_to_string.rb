class ChangeCuisineToString < ActiveRecord::Migration[5.1]
  def change
    change_column :recipes, :cuisine, :string
    Recipe.update_all(cuisine: "cocktail")
  end
end
