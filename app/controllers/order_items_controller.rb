class OrderItemsController < ApplicationController
# Cart set in application controller, giving us use of the @order variable
  def create
    @product = Product.find(params[:order_item][:product_id])

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
        flash[:notice] = 'Item successfully added to cart'
      else
        flash[:alert] = 'There was an error adding your item to the cart'
      end
    end
    redirect_to product_path(@product)
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
  end

  def index
    @order_items = @order.order_items
  end

  private

  def order_item_params
    params.require(:order_item).permit(:product_id,
                                         :quantity)
  end
end
