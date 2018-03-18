class OrdersController < ApplicationController
  def update_addresses
    @order.update_attributes(order_address_params)
    if @order.valid?
      flash[:notice] = 'Addresses successfully added'
      redirect_to root_path
    else
      flash[:alert] = 'There was an error adding your addresses, please try again'
      new_checkout_address_path
    end
  end

  private

  def order_address_params
    params.require(:order).permit(:billing_address_id, :shipping_address_id)
  end
end
