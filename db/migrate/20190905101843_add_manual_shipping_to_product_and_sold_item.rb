class AddManualShippingToProductAndSoldItem < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :manual_shipping, :boolean
    add_column :sold_items, :manual_shipping, :boolean
  end
end
