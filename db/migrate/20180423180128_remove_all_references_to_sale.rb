class RemoveAllReferencesToSale < ActiveRecord::Migration[5.1]
  def change
    remove_column :sold_items, :sale_id
  end
end
