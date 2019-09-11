class Distiller::BatchesController < DistillersController
  before_action :find_batch, only: [:mark_as_shipped, :show]
  before_action :check_batch_belongs_to_distiller, only: [:mark_as_shipped, :show]

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
    redirect_to distiller_batch_path(batch)
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
    @sold_items = @batch.sold_items
    scanform = EasyPost::ScanForm.retrieve(@batch.scanform_id)
    @scanform_url = scanform[:form_url]
  end

  def index
    @batches = current_distillery.batches.order("created_at DESC").page(params[:page])
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
