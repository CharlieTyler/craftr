class Distiller::SoldItemsController < DistillersController
  before_action :find_sold_item, only: [:show]
  before_action :verify_order_item_belongs_to_distiller, only: [:show]

  def show
    @postages = @sold_item.postages.order("created_at DESC")
  end

  def index
    @fulfilled_sold_items = current_distillery.sold_items.where(shipped: true)
  end

  private

  def find_sold_item
    @sold_item = SoldItem.find(params[:id])
  end

  def verify_order_item_belongs_to_distiller
    unless @sold_item.product.distillery == current_distillery
      flash[:alert] = "Unfortunately, this order does not belong to you!"
      redirect_to distiller_dashboard_path
    end
  end
end
