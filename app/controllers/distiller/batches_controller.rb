class Distiller::BatchesController < DistillersController
  before_action :find_batch, only: [:mark_as_shipped, :show]
  before_action :check_batch_belongs_to_distiller, only: [:mark_as_shipped, :show]

  def create
    sold_items = params[:batch][:sold_item_ids].reject(&:empty?)
    
    # Create shipment labels in easypost
    sold_items.each do |sold_item|
      post_item = SoldItem.find(sold_item)
      unless post_item.manual_shipping == true
        post_item.quantity.times do
          parcel       = EasyPost::Parcel.create(
                          predefined_package: 'SMALLPARCEL',
                          weight: post_item.product.weight
                         )
          toAddress   = EasyPost::Address.retrieve(post_item.order.shipping_address.easypost_address_id)
          fromAddress = EasyPost::Address.retrieve(post_item.product.distillery.address.easypost_address_id)
          shipment    = EasyPost::Shipment.create(
                          to_address: toAddress,
                          from_address: fromAddress,
                          parcel: parcel,
                          carrier_account_id: "ca_c3a3178260c54bac8e41f01df1340b14",
                          options: {alcohol: true}
                         )
          shipment.buy(
            rate: shipment.lowest_rate(carrier_accounts = ['RoyalMail'], service = ['RoyalMail2ndClass'])
          )
          post_item.postages.create(postage_label_url: shipment.postage_label.label_url, tracking_code: shipment.tracking_code, easypost_shipment_id: shipment.id)
        end
        post_item.update_attributes(shipping_label_created: true, shipping_label_created_at: Time.now.in_time_zone('London'))
      end
    end

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
    @scanform_id = @batch.scanform_id

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
