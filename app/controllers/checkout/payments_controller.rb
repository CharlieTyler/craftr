class Checkout::PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_items_in_cart
  before_action :check_order_has_address
  before_action :check_order_has_shipping_type
  before_action :check_all_products_live_and_in_stock

  def new

  end

  def create
    # STRIPE PAYMENT
    # Amount in cents
    @amount = @order.total_amount

    # Find Stripe customer, or create if not present
    if current_user.stripe_customer_id.present?
      customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
    else
      customer = Stripe::Customer.create(
        email: current_user.email,
        source: params[:stripeToken]
      )
      current_user.update_attributes(stripe_customer_id: customer.id)
      # Possibly should check if valid at this point, but don't want to reject transaction for some other username format issue etc.
    end

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: 'Craftr purchase',
      currency: 'gbp'
    )

    # SHIPPING - EASYPOST
    # May want to move to a worker server so that payment page isn't delayed? e.g. @order.queue_shipment_creation
    # Read up on queueing jobs other than emails
    # @order.create_shipments

    # BACKEND STUFF
    @order.denormalise_order
    session[:confirmed_order_id] = @order.id
    @order.update_attributes(state: "paid")
    session[:order_id] = nil
    flash[:notice] = "Order confirmed"
    redirect_to checkout_confirmation_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path
  end

  private

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

  def check_all_products_live_and_in_stock
    @order.order_items.each do |oi|
      unless oi.product.live_and_in_stock?
        flash[:alert] = "#{oi.product.name} is currently out of stock, please remove from basket before proceeding"
        redirect_to cart_path
      end
    end
  end
end
