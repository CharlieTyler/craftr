class RemoveSaleTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :sales
    rename_table :sale_items, :sold_items
  end
end
