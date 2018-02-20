class CreateArticleProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :article_products do |t|
      t.integer :article_id
      t.integer :product_id
      t.timestamps
    end
  end
end
