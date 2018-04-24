class AddDenormalisedShippingTotal < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :paid_shipping_price, :integer
  end
end
