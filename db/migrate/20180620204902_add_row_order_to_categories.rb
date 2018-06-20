class AddRowOrderToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :row_order, :integer
  end
end
