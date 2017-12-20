class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.text :message
      t.integer :rating
      t.integer :user_id
      t.integer :product_id
      t.timestamps
    end

    add_index :reviews, [:user_id, :product_id]
    add_index :reviews, :product_id
  end
end
