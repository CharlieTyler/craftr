class RenameLiveAndInStockToTrailingIs < ActiveRecord::Migration[5.1]
  def change
    rename_column :products, :live?, :is_live
    rename_column :products, :in_stock?, :is_in_stock
  end
end
