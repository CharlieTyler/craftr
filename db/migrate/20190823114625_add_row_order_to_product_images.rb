class AddRowOrderToProductImages < ActiveRecord::Migration[5.1]
  def change
    add_column :product_images, :row_order, :integer
  end
end
