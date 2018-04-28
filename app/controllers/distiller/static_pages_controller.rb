class Distiller::StaticPagesController < DistillersController
  def dashboard
    @products               = current_distillery.products
    @unfulfilled_sold_items = current_distillery.sold_items.order("created_at DESC")
    @fulfilled_sold_items   = current_distillery.sold_items.where(status: "shipped")
  end
end
