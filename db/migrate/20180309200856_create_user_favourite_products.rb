class CreateUserFavouriteProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :user_favourite_products do |t|
      t.integer :user_id
      t.integer :product_id
      t.timestamps
    end
  end
end
