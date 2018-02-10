class AddBannerImageToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :banner_image, :string
  end
end
