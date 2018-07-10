class RenameScanformCreatedAtAndReinstateShippingLabelCreatedAt < ActiveRecord::Migration[5.1]
  def change
    rename_column :batches, :shipping_label_created_at, :scanform_created_at
    add_column :sold_items, :shipping_label_created_at, :datetime
  end
end
