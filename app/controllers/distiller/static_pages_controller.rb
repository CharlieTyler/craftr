class Distiller::StaticPagesController < DistillersController
  def dashboard
    @products                                 = current_distillery.products
    @unshipped_batches                        = current_distillery.batches.where(shipped: false).order("created_at DESC")
    @unbatched_sold_items_with_postage_labels = current_distillery.sold_items.where(batch_id: nil).order("created_at DESC")
    @sold_items_without_postage_labels        = current_distillery.sold_items.where(batch_id: nil, shipping_label_created: false).order("created_at DESC")
    @batch                                    = Batch.new
    @batch.sold_items.build
  end

  def reports
    
  end
end
