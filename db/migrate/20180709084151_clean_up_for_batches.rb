class CleanUpForBatches < ActiveRecord::Migration[5.1]
  def change
    add_column :batches, :distillery_id, :integer
    add_column :batches, :shipped_at, :datetime
    add_column :batches, :shipping_label_created_at, :datetime
    add_column :sold_items, :batch_id, :integer
    remove_column :sold_items, :scan_form_id
    remove_column :sold_items, :shipped
    remove_column :sold_items, :shipped_at
    remove_column :sold_items, :shipping_created_at
  end
end
