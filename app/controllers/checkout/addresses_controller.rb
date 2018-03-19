class Checkout::AddressesController < AddressesController
  before_action :authenticate_user!
  before_action :check_items_in_cart
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

end
