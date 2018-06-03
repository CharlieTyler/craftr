class ChangeOrderStateToBooleanAttributes < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :state
    add_column :orders, :paid, :boolean, default: false
    add_column :orders, :shipping_label_created, :boolean, default: false
    add_column :orders, :shipped, :boolean, default: false
  end
end
