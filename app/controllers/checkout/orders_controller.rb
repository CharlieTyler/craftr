class Checkout::OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:add_voucher]
  before_action :check_voucher_is_valid_if_present
  before_action :check_items_in_cart, except: [:confirmation]
  before_action :check_all_products_and_distilleries_transactional, except: [:confirmation]
  before_action :check_order_has_shipping_type, except: [:add_voucher, :update_shipping, :confirmation]
  before_action :check_order_has_address, only: [:payment, :charge_payment]
  # before_action :check_user_is_beta_tester, only: [:payment, :charge_payment]

  def add_voucher
    @voucher = Voucher.where(code: params[:code]).first
    if @voucher.present?
      if @voucher.is_in_date_and_live 
        @order.update_attributes(voucher_id: @voucher.id)
      else
        flash[:alert] = "That voucher is not valid"
      end
    else
      flash[:alert] = "We didn't find a voucher with that code"
    end
    redirect_to cart_path
  end

  def update_shipping
    @order.update_attributes(order_shipping_params)
    if @order.valid?
      redirect_to checkout_address_path
    else
      flash[:alert] = 'There was an error setting your shipping method, please try again'
      redirect_to cart_path
    end
  end

  def address
    # This is first page of checkout process
    @address = Address.new
    @shipping_types = ShippingType.all
  end

  def create_address
    @address = current_user.addresses.create(address_params)
    if @address.valid?
      # Creates easy_post_address in after_create action
      @order.update_attributes(shipping_address_id: @address.id)
      if @order.valid?
        redirect_to checkout_payment_path
      else
        flash[:alert] = 'There was an error setting your shipping address, please try again'
        render :address, status: :unprocessable_entity
      end
    else
      flash[:alert] = 'Invalid address'
      render :address, status: :unprocessable_entity
    end
  end

  def update_address
    @order.update_attributes(order_address_params)
    if @order.valid?
      redirect_to checkout_payment_path
    else
      flash[:alert] = 'There was an error setting your shipping address, please try again'
      redirect_to checkout_address_path
    end
  end

  def payment

  end

  def charge_payment
    # STRIPE PAYMENT
    # Amount in cents
    @amount = @order.total_unpaid_amount

    # Find Stripe customer, or create if not present
    if current_user.stripe_customer_id.present?
      customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
    else
      customer = Stripe::Customer.create(
        email: current_user.email,
        source: params[:stripeToken]
      )
      current_user.update_attributes(stripe_customer_id: customer.id)
      # Is there a possibility that this update_attributes could fail validation if we introduce new user validation criteria?
      # Possibly should check if valid at this point, but don't want to reject transaction for some other username format issue etc.
    end

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: @order.product_summary,
      currency: 'gbp'
    )

    @order.order_items.each do |oi|
      transfer = Stripe::Transfer.create({
        :amount => oi.product.distillery_take * oi.quantity,
        :currency => "gbp",
        # Source transaction means payment doesn't go out until funds are processed. Also means trasfer group param not necessary
        :source_transaction => charge.id,
        :destination => oi.product.distillery.stripe_id,
      })
    end


    # BACKEND STUFF
    @order.denormalise_order
    # Uses worker server to send email
    @order.queue_confirmation_email
    @order.queue_distiller_emails
    @order.queue_distiller_reminder_emails
    @order.queue_please_review_email
    @order.queue_admin_emails

    session[:confirmed_order_id] = @order.id
    @order.update_attributes(paid: true)

    @order.queue_shipment_creation
    session[:order_id] = nil
    redirect_to checkout_confirmation_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to checkout_payment_path
  end

  def confirmation
    if session[:confirmed_order_id].present?
      @confirmed_order = Order.find(session[:confirmed_order_id])
      @relevant_recipes = @confirmed_order.order_items.first.product.related_recipes
    else
      @confirmed_order = ""
    end
    session[:confirmed_order_id] = nil
  end

  private

  def check_voucher_is_valid_if_present
    if @order.voucher.present?
      unless @order.voucher.is_in_date_and_live
        @order.update_attributes(voucher_id: nil)
        flash[:alert] = "You had an invalid voucher attached to your order, so we removed it"
        redirect_to cart_path
      end
    end
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
      redirect_to cart_path
    end
  end

  def check_all_products_and_distilleries_transactional
    @order.order_items.each do |oi|
      unless oi.product.is_transactional
        flash[:alert] = "#{oi.product.name.titleize} is currently not available, please remove from basket before proceeding"
        redirect_to cart_path
      end
    end
  end

  def check_user_is_beta_tester
    unless current_user.is_beta_tester
      flash[:notice] = "Craftr is currently only transactional for beta testers. Please email support@craftr.co.uk if you wish to become one!"
      redirect_to cart_path
    end
  end

  def address_params
    params.require(:address).permit(:first_name,
                                    :last_name,
                                    :phone_number,
                                    :line_1,
                                    :line_2,
                                    :line_3,
                                    :post_town,
                                    :postcode)
  end


  def order_address_params
    params.require(:order).permit(:shipping_address_id)
  end

  def order_shipping_params
    params.require(:order).permit(:shipping_type_id)
  end
end
