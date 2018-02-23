class ChangeRecipeForeignKeyToAuthor < ActiveRecord::Migration[5.1]
  def change
    rename_column :recipes, :user_id, :author_id
  end
end
