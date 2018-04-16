class AddEasypostIdToAddressesAndAddressToDistilleries < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :easypost_address_id, :string
    add_column :addresses, :distillery_id, :integer
  end
end
