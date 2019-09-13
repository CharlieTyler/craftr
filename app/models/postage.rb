class Postage < ApplicationRecord
  belongs_to :sold_item
  
  def batch_locally_if_batched_on_easypost
    # Find easypost shipment and its batch_id
    shipment = EasyPost::Shipment.retrieve(self.easypost_shipment_id)
    batch_id = shipment.batch_id
    # If it's been batched
    if batch_id.present?
      # Then if the local batch exists
      local_batch = Batch.find_by(easypost_batch_id: batch_id)
      if local_batch.present?
        # Update related sold_item to have that batch_id
        sold_item.update_attributes(batch_id: local_batch.id)
      else
        # Otherwise create the local batch and update the sold_item to belong to that
        ep_batch = EasyPost::Batch.retrieve(batch_id)
        scan_form = ep_batch.create_scan_form()
        new_local_batch = Batch.create(distillery_id: sold_item.product.distillery.id, easypost_batch_id: shipment.batch_id, scanform_id: scan_form[:scan_form][:id], scanform_created_at:  Time.now.in_time_zone('London'))
        sold_item.update_attributes(batch_id: new_local_batch.id)
      end
    end
  end
end
