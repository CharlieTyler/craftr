class CreateCollectionProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :collection_products do |t|
      t.integer :collection_id
      t.integer :product_id
      t.boolean :featured
      t.timestamps
    end
  end
end
