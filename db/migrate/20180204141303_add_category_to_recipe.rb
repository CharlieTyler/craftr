class AddCategoryToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :category, :string
    change_column :recipes, :description, :string
  end
end
