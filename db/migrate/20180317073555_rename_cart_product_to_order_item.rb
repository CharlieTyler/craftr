class RenameCartProductToOrderItem < ActiveRecord::Migration[5.1]
  def change
    rename_table :cart_products, :order_items
  end
end
