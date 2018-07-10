class Distiller::BatchesController < DistillersController
  def create
    easypost_batch = EasyPost::Batch.create()
    batch = current_distillery.batches.create(easypost_batch_id: easypost_batch.id)
    # Find the sold_item, then for each postage, retrieve the easypost shipment and add it to the batch
    params[:batch][:sold_item_ids].reject(&:empty?).each {
      |si| SoldItem.find(si).postages.map{
        |p| easypost_batch.add_shipments({shipments: [{id: p.easypost_shipment_id}]})
      }
      # Mimic this association in internal database
      SoldItem.find(si).update_attributes(batch_id: batch.id)
    }
    scan_form = easypost_batch.create_scan_form()
    batch.update_attributes(scanform_created_at: Time.now.in_time_zone('London'), scanform_id: scan_form[:scan_form][:id])
    flash[:notice] = "Batch successfully created"
    redirect_to distiller_dashboard_path
  end

  def mark_as_shipped
    @batch = Batch.find(params[:id])
    @batch.update_attributes(shipped: true, shipped_at: Time.now.in_time_zone('London'))
    @batch.sold_items.each do |si|
      si.update_attributes(shipped: true, shipped_at: Time.now.in_time_zone('London'))
      si.queue_shipped_email
    end
    respond_to do |format|
      format.js
    end
  end

  private

  # Currently not used - [TODO] how to make this more secure?
  def batches_params
    params.require(:batch).permit(sold_item_ids: [])
  end
end
