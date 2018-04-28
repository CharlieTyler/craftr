class OrderItemsController < ApplicationController

  before_action :find_product, only: [:create]
  before_action :check_all_products_and_distilleries_transactional, only: [:create]

  include ActionView::Helpers::TextHelper
  # So we can use pluralize method
  # @order set in application controller, giving us use of the @order variable
  def create
    # Product found in before_action
    # Check if this product is already in the cart
    current_order_item = @order.order_items.find_by(product_id: @product.id)
    if current_order_item.present?
      # Change the quantity
      current_order_item.quantity += params[:order_item][:quantity].to_i
      # Save the change quantity
      current_order_item.save
      flash[:notice] = "You now have #{current_order_item.quantity} of these in your cart"
    else
      @order_item = @order.order_items.create(order_item_params)
      if @order_item.valid?
        flash[:notice] = "#{pluralize(params[:order_item][:quantity], 'item')}  successfully added to cart"
        #Doesn't seems to work for now
      else
        flash[:alert] = 'There was an error adding your item to the cart'
      end
    end
    redirect_to product_path(@product)
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
