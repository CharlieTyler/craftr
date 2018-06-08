class AddScanformIdToSoldItems < ActiveRecord::Migration[5.1]
  def change
    add_column :sold_items, :scan_form_id, :string
  end
end
