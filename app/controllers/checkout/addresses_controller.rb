class Checkout::AddressesController < AddressesController
  # Inherits params from addresses controller
  def create
    if user_signed_in?
      @address = current_user.addresses.create(address_params)
    else
      @address = Address.create(address_params)
    end
    if @address.valid?
      flash[:notice] = 'Address successfully created'
    else
      flash[:alert] = 'Invalid address'
    end
    redirect_to me_path      
  end

  def update

  end

  def destroy

  end
end
