class AddShippingTypeIdToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :shipping_type_id, :integer
  end
end
