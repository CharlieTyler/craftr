class RenameCartIdToOrderId < ActiveRecord::Migration[5.1]
  def change
    rename_column :order_items, :cart_id, :order_id
  end
end
