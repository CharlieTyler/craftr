class AddEasypostShipmentIdToPostages < ActiveRecord::Migration[5.1]
  def change
    add_column :postages, :easypost_shipment_id, :string
  end
end
