class CreateRecipeComments < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_comments do |t|
      t.text :message
      t.integer :user_id
      t.integer :recipe_id
      t.timestamps
    end
  end
end
