class AddIndexesToMultipleModels < ActiveRecord::Migration[5.1]
  def change
    add_index :orders, :paid
    add_index :articles, :featured
    add_index :categories, :featured
    add_index :recipes, :featured
    add_index :products, :featured
    add_index :products, :is_live
    add_index :sold_items, :shipped
  end
end
