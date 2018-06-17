class AddIsTestToProductAndDistillery < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :is_test, :boolean, default: false
    add_column :distilleries, :is_test, :boolean, default: false
  end
end
