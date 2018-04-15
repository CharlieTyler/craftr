class OrdersController < ApplicationController
  def update_addresses
    @order.update_attributes(order_address_params)
    if @order.valid?
      redirect_to new_checkout_payment_path
    else
      flash[:alert] = 'There was an error setting your shipping address, please try again'
      redirect_to new_checkout_address_path
    end
  end

  def update_shipping
    @order.update_attributes(order_shipping_params)
    if @order.valid?
      redirect_to new_checkout_address_path
    else
      flash[:alert] = 'There was an error setting your shipping method, please try again'
      redirect_to cart_path
    end
  end

  private

  def order_address_params
    params.require(:order).permit(:shipping_address_id)
  end

  def order_shipping_params
    params.require(:order).permit(:shipping_type_id)
  end
end
