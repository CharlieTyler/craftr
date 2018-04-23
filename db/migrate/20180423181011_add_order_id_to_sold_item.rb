class AddOrderIdToSoldItem < ActiveRecord::Migration[5.1]
  def change
    add_column :sold_items, :order_id, :integer
  end
end
