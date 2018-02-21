class AddDescriptionAndVariantsToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :blurb, :text
    add_column :recipes, :variants, :text
  end
end
