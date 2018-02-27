class AddInstagramTagsAndUsernames < ActiveRecord::Migration[5.1]
  def change
    rename_column :authors, :instagram, :instagram_username
    add_column :categories, :instagram_hashtag, :string
    add_column :distilleries, :instagram_username, :string
    add_column :recipes, :instagram_hashtag, :string
  end
end
