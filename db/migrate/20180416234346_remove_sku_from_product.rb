class RemoveSkuFromProduct < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :SKU
  end
end
