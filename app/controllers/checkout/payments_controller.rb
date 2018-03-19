class Checkout::PaymentsController < ApplicationController
  before_action :check_items_in_cart
  before_action :check_order_has_address
  before_action :check_order_has_shipping_type

  def new

  end

  def create
    # Amount in cents
    @amount = @order.total_amount

    customer = Stripe::Customer.create(
      email: current_user.email,
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: 'Craftr purchase',
      currency: 'gbp'
    )

    @order.update_attributes(state: "complete")
    session[:order_id] = nil
    flash[:notice] = "Order confirmed"
    redirect_to root_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path
  end

  private

  def payment_params

  end

  def check_items_in_cart
    unless @order.order_items.length > 0
      flash[:alert] = 'Your cart is empty, please add items before checking out'
      redirect_to root_path
    end    
  end

  def check_order_has_address
    unless @order.shipping_address.user == @order.user
      flash[:alert] = 'Please enter a valid shipping address before attempting to pay'
      redirect_to checkout_addresses_path
    end
  end

  def check_order_has_shipping_type
    if @order.shipping_type_id.blank?
      flash[:alert] = 'Please select a shipping type before attempting to pay'
      redirect_to checkout_addresses_path
    end
  end
end
