class AddContentsmlToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :size_ml, :integer
  end
end
