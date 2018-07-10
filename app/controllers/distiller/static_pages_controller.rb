class Distiller::StaticPagesController < DistillersController
  def dashboard
    @products               = current_distillery.products
    @unfulfilled_sold_items = current_distillery.sold_items.where(batch_id: nil).order("created_at DESC")
    @unshipped_batches      = current_distillery.batches.where(shipped: false).order("created_at DESC")
    @shipped_batches        = current_distillery.batches.where(shipped: true).order("created_at DESC")
    @batch                  = Batch.new
    @batch.sold_items.build
  end

  def reports
    
  end
end
