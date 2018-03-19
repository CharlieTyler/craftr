class RemoveBillingAddressFromOrder < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :billing_address_id
  end
end
