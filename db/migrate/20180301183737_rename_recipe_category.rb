class RenameRecipeCategory < ActiveRecord::Migration[5.1]
  def change
    rename_column :recipes, :category, :tag
  end
end
