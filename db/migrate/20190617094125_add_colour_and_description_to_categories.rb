class AddColourAndDescriptionToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :gradient_from, :string
    add_column :categories, :gradient_to, :string
    add_column :categories, :description, :text
  end
end
