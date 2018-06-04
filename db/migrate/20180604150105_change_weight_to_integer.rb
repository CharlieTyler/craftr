class ChangeWeightToInteger < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :weight
    add_column :products, :weight, :integer
  end
end
