class ChangeIngredientTypeClassToCategory < ActiveRecord::Migration[5.1]
  def change
    rename_column :ingredients, :type, :category
  end
end
