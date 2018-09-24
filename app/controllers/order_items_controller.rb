class OrderItemsController < ApplicationController
  before_action :find_product, only: [:create]
  before_action :check_all_products_and_distilleries_transactional, only: [:create]

  include ActionView::Helpers::TextHelper
  # So we can use pluralize method
  # @order set in application controller, giving us use of the @order variable
  def create
    # Queue abandoned basket email to be sent if this is the first item being added (only queue once)
    # Note: if they keep adding and removing the first item, this will queue multiple.
    unless @order.order_items.length > 0
      @order.queue_abandoned_basket_email
    end
    # Product found in before_action
    # Check if this product is already in the cart
    current_order_item = @order.order_items.find_by(product_id: @product.id)
    if current_order_item.present?
      # Change the quantity
      current_order_item.quantity += params[:order_item][:quantity].to_i
      # Save the change quantity
      current_order_item.save
      # For partial rendering
      @order_item = current_order_item 
    else
      @order_item = @order.order_items.create(order_item_params)
      unless @order_item.valid?
      end
    end
    @order = @order_item.order.reload
    # To allow for create.js.erb to reload partials with updated order
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
    redirect_to cart_path
  end

  def index
    # This is the basket page

    @order_items = @order.order_items
    @shipping_types = ShippingType.all
    @default_shipping_type = ShippingType.first
  end

  private
  
  def find_product
    @product = Product.find(params[:order_item][:product_id])
  end

  def check_all_products_and_distilleries_transactional
    unless @product.is_transactional
      flash[:alert] = 'This product is currently unavailable, please select another'
      redirect_to request.referrer
    end
  end


  def order_item_params
    params.require(:order_item).permit(:product_id,
                                         :quantity)
  end
end
