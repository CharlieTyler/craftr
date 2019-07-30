class AddGtinToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :GTIN, :string
  end
end
