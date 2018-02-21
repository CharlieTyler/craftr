class AddTextAndImagesToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :banner_image, :string
    add_column :articles, :image_first, :string
    add_column :articles, :image_second, :string
    add_column :articles, :image_third, :string
    add_column :articles, :description_first, :text
    add_column :articles, :description_second, :text
    add_column :articles, :description_third, :text
  end
end
