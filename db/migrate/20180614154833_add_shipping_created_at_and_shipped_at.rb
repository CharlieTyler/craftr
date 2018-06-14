class AddShippingCreatedAtAndShippedAt < ActiveRecord::Migration[5.1]
  def change
    add_column :sold_items, :shipping_created_at, :datetime
    add_column :sold_items, :shipped_at, :datetime
  end
end
