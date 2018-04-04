class AddSections4And5ToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :description_fourth, :text
    add_column :articles, :description_fifth, :text
    add_column :articles, :image_fourth, :string
    add_column :articles, :image_fifth, :string
  end
end
