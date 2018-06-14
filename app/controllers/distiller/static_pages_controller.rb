class Distiller::StaticPagesController < DistillersController
  def dashboard
    @products               = current_distillery.products
    @unfulfilled_sold_items = current_distillery.sold_items.where(shipped: false).order("created_at DESC")
    @fulfilled_sold_items   = current_distillery.sold_items.where(shipped: true)
  end

  def reports
    
  end
end
