class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :SKU
      t.string :name
      t.float :price
      t.text :description_short
      t.text :description_first
      t.text :description_second
      t.float :alcohol_percentage
      t.integer :distillery_id
      t.integer :category_id
      t.timestamps
    end
  end
end
