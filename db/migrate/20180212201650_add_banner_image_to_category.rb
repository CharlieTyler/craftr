class AddBannerImageToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :banner_image, :string
  end
end
