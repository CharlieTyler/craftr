class Distiller::BatchesController < DistillersController
  before_action :find_batch, only: [:mark_as_shipped, :show]
  before_action :check_batch_belongs_to_distiller, only: [:mark_as_shipped, :show]

  def create
    # Create the batch in easypost
    easypost_batch = EasyPost::Batch.create()

    # Mimic it in local database, with the easypost_batch_id saved
    batch = current_distillery.batches.create(easypost_batch_id: easypost_batch.id)
    batch_counter = 0

    # Find the sold_item, then for each postage
    params[:batch][:sold_item_ids].reject(&:empty?).each do |si_id|
      si = SoldItem.find(si_id)
      si.postages.each do |postage|
        # check if it's been batched on easypost (shouldn't have been)
        shipment = EasyPost::Shipment.retrieve(postage.easypost_shipment_id)
        if shipment.batch_id.present?
          # reflect locally if has been batched
          postage.batch_locally_if_batched_on_easypost
          flash[:notice] = "Some of these items had already been batched. Check back on distiller dashboard for these forms and manifest"
        else
          easypost_batch.add_shipments({shipments: [{id: postage.easypost_shipment_id}]})
          batch_counter += 1
          si.update_attributes(batch_id: batch.id)
        end
      end
    end

    # If stuff has been added, create the bloody scanform and save it. Send to that path.
    if batch_counter > 0
      scan_form = easypost_batch.create_scan_form()
      batch.update_attributes(scanform_created_at: Time.now.in_time_zone('London'), scanform_id: scan_form[:scan_form][:id])
      redirect_to distiller_batch_path(batch)
    # Otherwise delete it and send back to dashboard - nothing to see here
    else
      batch.delete
      redirect_to distiller_dashboard_path
    end
  end

  # This is for auto postage only. Manual postages happen in the sold_items controller
  def mark_as_shipped
    @batch.update_attributes(shipped: true, shipped_at: Time.now.in_time_zone('London'))
    @batch.sold_items.each do |si|
      si.update_attributes(shipped: true, shipped_at: Time.now.in_time_zone('London'))
      si.queue_shipped_email
    end
    respond_to do |format|
      format.js
      format.html {
        flash[:notice] = "Order shipped email sent to customer"
        redirect_to distiller_dashboard_path
      }
    end
  end

  def show
    # Batch found in before action
    @sold_items = @batch.sold_items

    # Scanform retrieved each time as allows time for scanform_url to generate
    scanform = EasyPost::ScanForm.retrieve(@batch.scanform_id)
    @scanform_url = scanform[:form_url]
  end

  def index
    @batches = current_distillery.batches.order("created_at DESC")
    @manual_shipments = current_distillery.sold_items.where(manual_shipping: true)
  end

  private

  # Currently not used - [TODO] how to make this more secure?
  def batches_params
    params.require(:batch).permit(sold_item_ids: [])
  end

  def find_batch
    @batch = Batch.find(params[:id])
  end

  def check_batch_belongs_to_distiller
    unless @batch.distillery == current_distillery
      flash[:alert] = "You may only access or alter your own batches"
      redirect_to distiller_dashboard_path
    end
  end
end
