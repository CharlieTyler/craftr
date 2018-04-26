class AddDistilleryTakeToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :distillery_take, :integer
  end
end
