class CreateSaleItems < ActiveRecord::Migration[5.1]
  def change
    create_table :sale_items do |t|
      t.integer :sale_id
      t.integer :product_id
      t.integer :order_item_id
      t.integer :quantity
      t.integer :item_price
      t.string :status 
      t.timestamps
    end
  end
end
