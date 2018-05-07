class AddDistillerTakeToSoldItem < ActiveRecord::Migration[5.1]
  def change
    add_column :sold_items, :distillery_take, :integer
  end
end
