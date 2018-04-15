class Checkout::AddressesController < AddressesController
  before_action :authenticate_user!
  before_action :check_items_in_cart
  before_action :check_order_has_shipping_type
  before_action :check_all_products_live_and_in_stock

  # Inherits params from addresses controller
  def new
    # This is first page of checkout process
    @address = Address.new
    @shipping_types = ShippingType.all
  end

  def create
    @address = current_user.addresses.create(address_params)
    if @address.valid?
      flash[:notice] = 'Address successfully created'
    else
      flash[:alert] = 'Invalid address'
    end
    redirect_to new_checkout_address_path      
  end

  def update

  end

  def destroy

  end

  private

  def check_items_in_cart
    unless @order.order_items.length > 0
      flash[:alert] = 'Your cart is empty, please add items before checking out'
      redirect_to root_path
    end    
  end

  def check_order_has_shipping_type
    if @order.shipping_type_id.blank?
      flash[:alert] = 'Please select a shipping type before proceeding'
      redirect_to checkout_addresses_path
    end
  end

  def check_all_products_live_and_in_stock
    @order.order_items.each do |oi|
      unless oi.product.live_and_in_stock?
        flash[:alert] = "#{oi.product.name} is currently out of stock, please remove from basket before proceeding"
        redirect_to order_items_path
      end
    end
  end

end
