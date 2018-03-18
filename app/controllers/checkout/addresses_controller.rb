class Checkout::AddressesController < AddressesController
  # Inherits params from addresses controller
  def new
    # This is first page of checkout process
    @address = Address.new
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
end
