class MoveBooleansToSoldItemRatherThanOrder < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :shipping_label_created
    remove_column :orders, :shipped
    remove_column :sold_items, :status
    add_column :sold_items, :shipping_label_created, :boolean, default: false
    add_column :sold_items, :shipped, :boolean, default: false
  end
end
