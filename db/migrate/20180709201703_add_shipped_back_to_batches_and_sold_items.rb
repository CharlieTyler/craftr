class AddShippedBackToBatchesAndSoldItems < ActiveRecord::Migration[5.1]
  def change
    add_column :sold_items, :shipped, :boolean, default: false
    add_column :sold_items, :shipped_at, :datetime
  end
end
