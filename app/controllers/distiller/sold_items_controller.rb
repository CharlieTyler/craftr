class Distiller::SoldItemsController < DistillersController
  before_action :find_sold_item, only: [:show, :mark_as_shipped]
  before_action :verify_order_item_belongs_to_distiller, only: [:show, :mark_as_shipped]

  def show
    scan_form = EasyPost::ScanForm.retrieve(@sold_item.scan_form_id)
    @scan_form_url = scan_form[:form_url]
    @postages = @sold_item.postages.order("created_at DESC")
  end

  def index
    @fulfilled_sold_items = current_distillery.sold_items.where(shipped: true)
  end

  def mark_as_shipped
    @sold_item.update_attributes(shipped: true, shipped_at: Time.now)
    respond_to do |format|
      format.js
    end
    @sold_item.queue_shipped_email
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
