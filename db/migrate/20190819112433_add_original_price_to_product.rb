class AddOriginalPriceToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :original_price, :integer
  end
end
