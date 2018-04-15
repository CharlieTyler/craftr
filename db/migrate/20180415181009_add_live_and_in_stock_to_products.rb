class AddLiveAndInStockToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :live?, :boolean, default: true
    add_column :products, :in_stock?, :boolean, default: true
  end
end
