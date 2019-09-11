class Distiller::StaticPagesController < DistillersController
  def dashboard
    @products                                         = current_distillery.products

    @unbatched_sold_items                              = current_distillery.sold_items.where.not(manual_shipping: true).where(batch_id: nil)
    @unbatched_sold_items_auto_with_postage_labels    = @unbatched_sold_items.where(shipping_label_created: true)
    @unbatched_sold_items_auto_without_postage_labels = @unbatched_sold_items.where(shipping_label_created: false)
    @unshipped_auto_batches                           = current_distillery.batches.where(shipped: false).order("created_at DESC")
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
end

  def unshipped_batches
    batches.where(shipped: false)
  end

  def unbatched_sold_items_with_postage_labels
    sold_items.where.not(manual_shipping: true).where(batch_id: nil, shipping_label_created: true)
  end

  def unbatched_sold_items_without_postage_labels
    sold_items.where.not(manual_shipping: true).where(batch_id: nil, shipping_label_created: false)
  end

  # Manual shipping
  def unshipped_manual_sold_items
    sold_items.where(manual_shipping: true, shipped: false)
  end
