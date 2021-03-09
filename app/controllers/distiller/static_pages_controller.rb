class Distiller::StaticPagesController < DistillersController
  before_action :check_if_shipments_already_manifested, only: [:dashboard]
  def dashboard
    @products                                         = current_distillery.products

    @unbatched_sold_items_auto_with_postage_labels    = @unbatched_sold_items.where(shipping_label_created: true)
    @unbatched_sold_items_auto_without_postage_labels = @unbatched_sold_items.where(shipping_label_created: false)
    @unshipped_auto_batches                           = current_distillery.batches.where(shipped: false).order("created_at DESC")

    @unshipped_batches                                = current_distillery.batches.where(shipped: false).order("created_at DESC")
    
    @batch                                            = Batch.new
    @batch.sold_items.build

    # Manual ship
    @unshipped_manual_sold_items                      = current_distillery.unshipped_manual_sold_items.order("created_at DESC")
  end

  def reports
    unless current_distillery.sold_items.where(shipped: true).length > 50
      flash[:notice] = "Fulfil 50 orders to gain access to reporting"
      redirect_to distiller_dashboard_path
    end
  end

  private

  def check_if_shipments_already_manifested
    @unbatched_sold_items                             = current_distillery.sold_items.where(manual_shipping: [nil, false], batch_id: nil).order("created_at DESC")

    # if @unbatched_sold_items.length > 0
    #   # For each sold item, see if the shipments have been manifested
    #   @unbatched_sold_items.each do |si|
    #     # For each postage, retrieve the shipment and check if there's a batch
    #     si.postages.each do |p|
    #       p.batch_locally_if_batched_on_easypost
    #     end
    #   end
    # end
  end
end
